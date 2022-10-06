https://github.com/GoogleCloudPlatform/functions-framework-dotnet/tree/main/examples/Google.Cloud.Functions.Examples.SimpleHttpFunction

using Google.Cloud.Functions.Framework;
using Microsoft.AspNetCore.Http;
using System.Threading.Tasks;

namespace Google.Cloud.Functions.Examples.SimpleHttpFunction
{
    public class Function : IHttpFunction
    {
        /// <summary>
        /// Logic for your function goes here.
        /// </summary>
        /// <param name="context">The HTTP context, containing the request and the response.</param>
        /// <returns>A task representing the asynchronous operation.</returns>
        public async Task HandleAsync(HttpContext context)
        {
            await context.Response.WriteAsync("Hello, Functions Framework.");
        }
    }
}
