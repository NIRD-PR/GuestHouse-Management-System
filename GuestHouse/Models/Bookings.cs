using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Services.Description;

namespace GuestHouse.Models
{
    public class Bookings
    {
        public int BookingID { get; set; }

        [Display(Name = "First Name")]
        [Required(ErrorMessage = "This is a required field.")]
        public string FirstName { get; set; }

        [Display(Name = "Last Name")]
        [Required(ErrorMessage = "This is a required field.")]
        public string LastName { get; set; }

        [Display(Name = "Address")]
        [Required(ErrorMessage = "This is a required field.")]
        public string Address { get; set; }

        [Display(Name = "Booking From")]
        [Required(ErrorMessage = "This is a required field.")]
        public DateTime BookingFrom { get; set; }

        [Display(Name = "Booking To")]
        [Required(ErrorMessage = "This is a required field.")]
        public DateTime BookingTo { get; set; }

        [Display(Name = "Assign Room")]
        [Required(ErrorMessage = "This is a required field.")]
        public int AssignRoomID { get; set; }

        public int NoOfMembers { get; set; }

        [DataType(DataType.PhoneNumber)]
        public string PhoneNo { get; set; }
        public decimal TotalAmount {get; set;}

        public int BookingTypeID { get; set; }

        //for trainings
        public string trName { get; set; }
        public string trDirector { get; set; }
        public DateTime? trFrom { get; set; }
        public DateTime? trTo { get; set; }

        public string purpVis { get; set; }

        public string visWh { get; set; }

        public string cenVis { get; set; }

    }
}
