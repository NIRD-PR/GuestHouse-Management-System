using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GuestHouse.Models
{
    public class LoginUser
    {	
		public string FirstName { get; set; }
		public string LastName { get; set; }
		public string Email { get; set; }
		public string MobileNo { get; set; }
		public string ID { get; set; }
		public string PrimaryRole { get; set; }
		public string SecondaryRole { get; set; }

		public bool HasPrimaryRole(string roleName)
		{
			return String.Equals(this.PrimaryRole, roleName, StringComparison.OrdinalIgnoreCase);
		}

		public bool HasSecondaryRole(string roleName)
		{
			return String.Equals(this.SecondaryRole, roleName, StringComparison.OrdinalIgnoreCase);
		}
	}
}