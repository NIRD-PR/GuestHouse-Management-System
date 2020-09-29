using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace GuestHouse.Models
{
    public class RoomModel
    {
        public int RoomID { get; set; }

        [Required(ErrorMessage = "This is a required field.")]
        [RegularExpression(@"\d{3}", ErrorMessage = "Please enter 3 digit Room Number.")]
        public string RoomNumber { get; set; }

        public string RoomImage { get; set; }


        [Required(ErrorMessage = "This is a required field.")]
        public int RoomTypeID { get; set; }

        [Required(ErrorMessage = "This is a required field.")]
        public int RoomCapacity { get; set; }

        [Required(ErrorMessage = "This is a required field.")]
        public int GuestHouseID { get; set; }

        public string RoomDescription { get; set; }

        public HttpPostedFileBase InputImage { get; set; }


        // public List<SelectListItem> ListOfBookingStatus { get; set; }
    }
}