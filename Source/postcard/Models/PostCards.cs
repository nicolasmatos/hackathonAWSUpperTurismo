using System;
namespace postcard.Models
{
	public class PostCards
	{
		public int id { get; set; }
		public int id_uf { get; set; }
		public string uf { get; set; }
		public string cidade { get; set; }
		public string card { get; set; }
		public string descricao { get; set; }

		public string URLimg { get; set; }
	}
}

