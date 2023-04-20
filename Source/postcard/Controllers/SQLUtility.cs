using System;
using Microsoft.Extensions.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using postcard.Models;
using Microsoft.Data.SqlClient;
using static System.Reflection.Metadata.BlobBuilder;
using System.Reflection.Metadata;

namespace postcard.Controllers
{
	public class SQLUtility
	{
        public string getconnectionstring(IConfiguration configuration)
        {
            var connectionString = configuration.GetValue<string>("ConnectionStrings:SQLDatabaseConnection");
            return connectionString;
        }

		public async Task<List<Capas>> getcapas(string query, IConfiguration configuration)
        {
            var capas = new List<Capas>();			

			try
			{

                // Get Blobs in Azure Container Blob
                var blobs = new List<BlobContainer>();
                blobs = await new StorageUtility().getstorage(configuration);

                using (SqlConnection con = new SqlConnection(getconnectionstring(configuration)))
				{
					con.Open();
					SqlCommand cmd = new SqlCommand(query);
					cmd.Connection = con;

					SqlDataReader rdr = cmd.ExecuteReader();
					while (rdr.Read())
					{
						Capas capa = new Capas();

						capa.id = Convert.ToInt32(rdr["id"]);
                        capa.uf = rdr["uf"].ToString();
                        capa.estado = rdr["estado"].ToString();
                        capa.musica = rdr["musica"].ToString();
                        capa.youtube = rdr["youtube"].ToString();
                        capa.imagem = rdr["imagem"].ToString();


                       //Compare blobs
                       foreach (BlobContainer blob in blobs)
                       {
                            if (blob.name == capa.imagem)
                            {
                                capa.URLimg = blob.URL;
                            }
                       }

						capas.Add(capa);
                    }
				}
			}
			catch (SqlException ex)
			{
				throw ex;
            }
            return (capas);
		}

		public async Task<List<PostCards>> getcards(string query, IConfiguration configuration)
		{
            var cards = new List<PostCards>();

            try
            {
                // Get Blobs in Azure Container Blob
                var blobs = new List<BlobContainer>();
                blobs = await new StorageUtility().getstorage(configuration);

                using (SqlConnection con = new SqlConnection(getconnectionstring(configuration)))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(query);
                    cmd.Connection = con;

                    SqlDataReader rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        PostCards card = new PostCards();

                        card.id = Convert.ToInt32(rdr["id"]);
                        card.id_uf = Convert.ToInt32(rdr["id_uf"]);
                        card.uf = rdr["uf"].ToString();
                        card.cidade = rdr["cidade"].ToString();
                        card.card = rdr["card"].ToString();
                        card.descricao = rdr["descricao"].ToString();


                        //Compare blobs
                        foreach (BlobContainer blob in blobs)
                        {
                            var path = "cards/" + card.uf + "/" + card.card;

                            if (blob.name == path)
                            {
                                card.URLimg = blob.URL;
                            }
                        }

                        cards.Add(card);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            return (cards);
        }
	}
}

