using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GuestHouse.Models
{
    public class BookingsViewModel
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string BookingType { get; set; }
        public int NoOfMembers { get; set; }

        public DateTime BookingTo { get; set; }
        public DateTime BookingFrom { get; set; }

        public string Address { get; set; }

        public decimal TotalAmount { get; set; }
        public string PhoneNo { get; set; }

        //for training details
        public string TrainingName { get; set; }
        public string TrainingDirector { get; set; }
        public DateTime? TrainingFrom { get; set; }
        public DateTime? TrainingTo { get; set; }

        //for official visit details.
        public string PurposeOfVisit { get; set; }
        public string CenterVisiting { get; set; }
        public string VisitingWhom { get; set; }
    }
}
