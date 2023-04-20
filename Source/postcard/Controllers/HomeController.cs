using System.Diagnostics;
using System.Net;
using Microsoft.AspNetCore.Mvc;
using postcard.Models;
using System.Net.Sockets;
using System.Configuration;
using Microsoft.Extensions.Configuration;

namespace postcard.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;
    private readonly IConfiguration _configuration;

    public HomeController(ILogger<HomeController> logger, IConfiguration configuration)
    {
        _configuration = configuration;
        _logger = logger;
    }

    public async Task<IActionResult> Index()
    {
        var model = new Home();
        var modelcapa = new List<Capas>();
        var hostname = Dns.GetHostEntry(Dns.GetHostName());

        foreach (var ip in hostname.AddressList)
        {
            if (ip.AddressFamily == AddressFamily.InterNetwork)
            {
                model.hostip = ip.ToString();
            }
        }
        
        modelcapa = await new SQLUtility().getcapas("SELECT Id, uf, estado, musica, youtube, imagem FROM capas", _configuration);

        model.listcapas = modelcapa;

        return View(model);
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}

