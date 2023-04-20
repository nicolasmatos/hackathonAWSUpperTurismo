using System;
using Microsoft.Extensions.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using postcard.Models;
using Microsoft.Data.SqlClient;
using System.IO;
using System.IO.Compression;
using Amazon.S3;
using Amazon;
using Amazon.S3.Model;
using Amazon.S3.Transfer;
using System.Net;

namespace postcard.Controllers
{
	public class StorageUtility
	{
        static IAmazonS3 awsS3Client;

        public List<string> getstorageconnectionstring(IConfiguration configuration)
        {            
            var connectionString = configuration.GetValue<string>("ConnectionStrings:AzureBlobStorageConnection");
            var BucketName = configuration.GetValue<string>("StorageS3:BucketName");
            var AwsAccessKey = configuration.GetValue<string>("StorageS3:AwsAccessKey");
            var AwsSecretAccessKey = configuration.GetValue<string>("StorageS3:AwsSecretAccessKey");

            var storageparams = new List<string>();

            storageparams.Add(connectionString);
            storageparams.Add(BucketName);
            storageparams.Add(AwsAccessKey);
            storageparams.Add(AwsSecretAccessKey);


            return storageparams;
        }

        public async Task<List<BlobContainer>> getstorage(IConfiguration configuration)
        {
            try
            {
                var storageparams = getstorageconnectionstring(configuration);

                awsS3Client = new AmazonS3Client(storageparams[2].ToString(), storageparams[3].ToString(), RegionEndpoint.USEast1);

                var container = new List<BlobContainer>();

               // var objetct = await awsS3Client.ListObjectsAsync(storageparams[1].ToString());

                ListObjectsV2Request listObjectsRequest = new ListObjectsV2Request();
                listObjectsRequest.BucketName = storageparams[1].ToString();
                ListObjectsV2Response listObjectsResponse = await awsS3Client.ListObjectsV2Async(listObjectsRequest);
                do
                {
                    List<S3Object> s3Objects = listObjectsResponse.S3Objects;

                    foreach (S3Object s3Object in s3Objects)
                    {

                        var request = new GetPreSignedUrlRequest
                        {
                            BucketName = s3Object.BucketName,
                            Key = s3Object.Key,
                            Expires = DateTime.UtcNow.AddMinutes(15)
                        };

                        var S3URL = awsS3Client.GetPreSignedURL(request);
                        
                        container.Add(new BlobContainer { name = s3Object.Key, URL = S3URL});
                    }
                }
                while (listObjectsResponse.IsTruncated);
               

                return container;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public async Task<byte[]> getstreamtodownload(IConfiguration configuration, string filename)
        {
            MemoryStream ms = null;

            try
            {
                var storageparams = getstorageconnectionstring(configuration);
                awsS3Client = new AmazonS3Client(storageparams[2].ToString(), storageparams[3].ToString(), RegionEndpoint.USEast1);

                GetObjectRequest getObjectRequest = new GetObjectRequest
                {
                    BucketName = storageparams[1].ToString(),
                    Key = filename
                };

                using (var response = await awsS3Client.GetObjectAsync(getObjectRequest))
                {
                    if (response.HttpStatusCode == HttpStatusCode.OK)
                    {
                        using(ms = new MemoryStream())
                        {
                            await response.ResponseStream.CopyToAsync(ms);
                        }
                    }
                }

                return ms.ToArray();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}

