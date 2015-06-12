using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(DefTrack.Startup))]
namespace DefTrack
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
