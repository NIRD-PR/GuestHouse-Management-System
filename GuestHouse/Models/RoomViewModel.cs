using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GuestHouse.Models
{
    public class RoomViewModel
    {
        public int RoomID { get; set; }
        public string RoomNumber { get; set; }
      //  public string RoomImage { get; set; }
        public string RoomPrice { get; set; }
        public string BookingStatus { get; set; }
        public string RoomType { get; set; }
        public int RoomCapacity { get; set; }
        public string RoomDescription { get; set; }

        public string GuestHouse { get; set; }
    }
}
