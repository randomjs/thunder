﻿using System.Web.Mvc;
using Thunder.Web.Mvc.Filter;

namespace Site.Controllers
{
    [LayoutInject("Site")]
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}
