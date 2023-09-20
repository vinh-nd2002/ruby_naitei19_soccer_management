module BookingHelper
  def render_status_class_name status
    case status
    when Booking.booking_statuses[:pending]
      "text-white bg-yellow-400 hover:bg-yellow-500 focus:outline-none
      focus:ring-4focus:ring-yellow-300 font-medium rounded-full text-sm px-5
      py-2.5 text-center mr-2 mb-2 dark:focus:ring-yellow-900"
    when Booking.booking_statuses[:approve]
      "text-white bg-green-700 hover:bg-green-800 focus:outline-none
      focus:ring-4 focus:ring-green-300 font-medium rounded-full text-sm px-5
      py-2.5 text-center mr-2 mb-2 dark:bg-green-600 dark:hover:bg-green-700
      dark:focus:ring-green-800"
    when Booking.booking_statuses[:reject]
      "text-white bg-red-700 hover:bg-red-800 focus:outline-none focus:ring-4
      focus:ring-red-300 font-medium rounded-full text-sm px-5 py-2.5
      text-center mr-2 mb-2 dark:bg-red-600 dark:hover:bg-red-700
      dark:focus:ring-red-900"
    when Booking.booking_statuses[:cancelled]
      "text-white bg-gray-800 hover:bg-gray-900 focus:outline-none focus:ring-4
      focus:ring-gray-300 font-medium rounded-full text-sm px-5 py-2.5 mr-2 mb-2
      dark:bg-gray-800 dark:hover:bg-gray-700 dark:focus:ring-gray-700
      dark:border-gray-700"
    when Booking.booking_statuses[:expired]
      "text-white bg-purple-700 hover:bg-purple-800 focus:outline-none
      focus:ring-4 focus:ring-purple-300 font-medium rounded-full text-sm px-5
      py-2.5 text-center mb-2 dark:bg-purple-600 dark:hover:bg-purple-700
      dark:focus:ring-purple-900"
    else
      "text-gray-900 bg-white border border-gray-300 focus:outline-none
      hover:bg-gray-100 focus:ring-4 focus:ring-gray-200 font-medium
      rounded-full text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-gray-800
      dark:text-white dark:border-gray-600 dark:hover:bg-gray-700
      dark:hover:border-gray-600 dark:focus:ring-gray-700"
    end
  end
end
