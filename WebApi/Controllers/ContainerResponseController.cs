using Microsoft.AspNetCore.Mvc;

namespace WebApi.Controllers;

[ApiController]
[Route("[controller]")]
public class ContainerResponseController : ControllerBase
{
    private readonly ILogger<ContainerResponseController> _logger;

    public ContainerResponseController(ILogger<ContainerResponseController> logger)
    {
        _logger = logger;
    }

    [HttpGet(Name = "/")]
    public dynamic Get()
    {
        return new 
        {
            Date = DateTime.UtcNow.AddHours(-3).ToString("MM/dd/yyyy HH:mm:ss"),
            ContainerId = Environment.MachineName
        };
    }
}