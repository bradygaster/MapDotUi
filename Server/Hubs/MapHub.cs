using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;

namespace BlazorSignalRApp.Server.Hubs
{
    public class MapHub : Hub
    {
        public async Task ReceiveLocation(string name, 
            double latitude,
            double longitude)
        {
            await Clients
                .Others
                .SendAsync("OnReceiveLocation", name, latitude, longitude);
        }
    }
}