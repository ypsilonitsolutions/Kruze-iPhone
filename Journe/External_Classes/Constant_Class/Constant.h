//
//  Constant.h
//  Journe
//
//  Created by admin on 19/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//External_Classes
#import "IQKeyboardManager.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import "HexColorToUIColor.h"
#import "CircularImage.h"
#import "WebService.h"
#import "MBProgressHUD.h"
#import "ECSlidingViewController.h"
#import "InitialSlidingViewController.h"
#import "MenuViewController.h"
#import "SplashVC.h"
#import "UIImage+animatedGIF.h"
#import "SeatListingVC.h"




//Classes
#import "LoginVC.h"
#import "SignUpVc.h"
#import "VerifyOtpVC.h"
#import "DashboardVC.h"
#import "SearchRouteVC.h"
#import "MemberIdentificationVC.h"
#import "FeedbackVC.h"
#import "ProfileVC.h"
#import "PerkVC.h"
#import "BookingDetailsVC.h"
#import "EditProfileVC.h"
#import "ContactVC.h"
#import "StopListingVC.h"
#import "Sugest_RoutVC.h"
#import "ThankYouVC.h"
#import "BookCarVC.h"
#import "WalletVC.h"
#import "Recent_TransVC.h"
#import "Current_BookVC.h"
#import "History_BookVC.h"
#import "Detail_CBookVC.h"
#import "DoneBookingVC.h"
#import "HistoryDetails.h"
#import "Kruze_PlayVC.h"
#import "YourRideVC.h"
#import "NotificationVC.h"
#import "RewardsHistoryVC.h"
#import "FAQ_VC.h"
#import "SharePointVC.h"

//Tableview_Cell
#import "SerachRouteCell.h"
#import "StopCell.h"
#import "RecentTransTVCell.h"
#import "SeatCell.h"
#import "Seater5Cell.h"
#import "Seater6Cell.h"
#import "Dashboard_cell.h"

//frameworks
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import <AssetsLibrary/AssetsLibrary.h>



//Driver_VC

#import "DriverDashVC.h"
#import "Dvr_KiloMetrVC.h"
#import "Dvr_Expense_ListVC.h"
#import "StartJourne.h"
#import "Dvr_HelpVC.h"
#import "Dvr_KmWeekendVC.h"
#import "ExpenseAddMore.h"
#import "Dvr_LoginVC.h"
#import "ExpenseAddMore.h"
#import "ExpensesDetailsVC.h"
#import "Dvr_Daily_ListVC.h"
#import "DvrWeekendListVC.h"
#import "QRCodeClass.h"
#import "Dvr_CashVC.h"
#import "Dvr_CashTVCell.h"

//Drive_Cell
#import "ExpenseListCell.h"
#import "Dvr_KiloMTVCell.h"
#import "Dvr_DailyTVCell.h"



@interface Constant : NSObject

#define fb_outline_color [[HexColorToUIColor colorFromHexString:@"3a5795"]CGColor]

#define google_outline_color [[HexColorToUIColor colorFromHexString:@"D54937"]CGColor]

#define sky_blue_color [[HexColorToUIColor colorFromHexString:@"26A9E0"]CGColor]

#define Background_blue_color [HexColorToUIColor colorFromHexString:@"26A9E0"]

#define text_gray_color [HexColorToUIColor colorFromHexString:@"303030"]


#define text_gray1_color [HexColorToUIColor colorFromHexString:@"#ff0202"]

#define completed_text_color [HexColorToUIColor colorFromHexString:@"#389844"]


#define running_text_color [HexColorToUIColor colorFromHexString:@"#f6ad0e"]

#define BASE_URL @"http://54.67.85.189/journe/webservices/passenger/"



#define DRIVER_BASE_URL @"http://54.67.85.189/journe/webservices/driver/"



#define Sign_Up ([NSString stringWithFormat :@"%@passenger_signup.php",BASE_URL])

#define Login_Url ([NSString stringWithFormat :@"%@passenger_login.php",BASE_URL])

#define OTP_verification_Url ([NSString stringWithFormat :@"%@passenger_verification.php",BASE_URL])


#define City_list_Url ([NSString stringWithFormat :@"%@city_list.php",BASE_URL])

#define Route_list_Url ([NSString stringWithFormat :@"%@route_list.php",BASE_URL])

#define SearchTrip_Url ([NSString stringWithFormat :@"%@search_2.php",BASE_URL])

#define ReturnTrip_Url ([NSString stringWithFormat :@"%@return_trip",BASE_URL])



#define UserProfile_Url ([NSString stringWithFormat :@"%@passenger_profile.php",BASE_URL])

#define UpdateUserProfile_Url ([NSString stringWithFormat :@"%@edit_profile_passenger.php",BASE_URL])


#define SearchLandmark_Url ([NSString stringWithFormat :@"%@landmark_list.php",BASE_URL])

#define ContactUs_Url ([NSString stringWithFormat :@"%@contact_us.php",BASE_URL])

#define StopList_Url ([NSString stringWithFormat :@"%@get_stops.php",BASE_URL])

#define PsgForgetPwd_Url ([NSString stringWithFormat :@"%@forgot_passowrd.php",BASE_URL])

#define PsgChangePwd_Url ([NSString stringWithFormat :@"%@change_password.php",BASE_URL])

#define PsgFeedback_Url ([NSString stringWithFormat :@"%@passenger_feedback.php",BASE_URL])

#define BookAcar_Url ([NSString stringWithFormat :@"%@bookcar.php",BASE_URL])

#define BookPlane_Url ([NSString stringWithFormat :@"%@plane_booking.php",BASE_URL])


#define SuggestRoutes_Url ([NSString stringWithFormat :@"%@suggest_route.php",BASE_URL])

#define SeatView_Url ([NSString stringWithFormat :@"%@get_trip_bus.php",BASE_URL])


#define BookSeat_Url ([NSString stringWithFormat :@"%@book_seats.php",BASE_URL])


#define CurrentBookings_Url ([NSString stringWithFormat :@"%@current_bookings.php",BASE_URL])

#define RewardsList_Url ([NSString stringWithFormat :@"%@rewards_history.php",BASE_URL])


#define RedeemRide_Url ([NSString stringWithFormat :@"%@redeem_ride.php",BASE_URL])


#define BookingHistory_Url ([NSString stringWithFormat :@"%@booking_history.php",BASE_URL])

#define Notification_Url ([NSString stringWithFormat :@"%@notification_list.php",BASE_URL])

#define CancelBookings_Url ([NSString stringWithFormat :@"%@cancel_booking.php",BASE_URL])

#define CompanyDetails_Url ([NSString stringWithFormat :@"%@company_details.php",BASE_URL])

#define TrackRide_Url ([NSString stringWithFormat :@"%@gps_location.php",BASE_URL])

#define Rewards_Url ([NSString stringWithFormat :@"%@rewards.php",BASE_URL])

#define SharePoints_Url ([NSString stringWithFormat :@"%@share_points.php",BASE_URL])

//Driver_UrlS
#define DriverLogin_Url ([NSString stringWithFormat :@"%@driver_login.php",DRIVER_BASE_URL])

#define DriverExpList_Url ([NSString stringWithFormat :@"%@get_driver_expenses.php",DRIVER_BASE_URL])
#define BusRoute_Url ([NSString stringWithFormat :@"%@bus_route_list.php",DRIVER_BASE_URL])

#define cancel_trip_API ([NSString stringWithFormat :@"%@cancel_trip.php",DRIVER_BASE_URL])

#define ExpensesTypeURL ([NSString stringWithFormat :@"%@expenses_categories.php",DRIVER_BASE_URL])

#define AddExpensesURL ([NSString stringWithFormat :@"%@add_expenses.php",DRIVER_BASE_URL])

#define Help_Web ([NSString stringWithFormat :@"%@driver_help.php",DRIVER_BASE_URL])

#define Show_KiloM ([NSString stringWithFormat :@"%@weekend_list.php",DRIVER_BASE_URL])

#define DailyRideList ([NSString stringWithFormat :@"%@km_list.php",DRIVER_BASE_URL])


#define Daily_RideTiming ([NSString stringWithFormat :@"%@bus_route_list.php",DRIVER_BASE_URL])

#define AddDailyKm ([NSString stringWithFormat :@"%@km_management.php",DRIVER_BASE_URL])

#define AddWeekendRide ([NSString stringWithFormat :@"%@add_weekend_ride",DRIVER_BASE_URL])

#define Passenger_booking_URL ([NSString stringWithFormat :@"%@passenger_booking_list.php",DRIVER_BASE_URL])

#define BoardedPassengerURL ([NSString stringWithFormat :@"%@boarded_passenger.php",DRIVER_BASE_URL])

#define AbsentPassengerURL ([NSString stringWithFormat :@"%@absent_passenger.php",DRIVER_BASE_URL])

#define CompanyListURL ([NSString stringWithFormat :@"%@company_list.php",DRIVER_BASE_URL])


#define reachStopURL ([NSString stringWithFormat :@"%@stop_reach.php",DRIVER_BASE_URL])


#define Cash_Api ([NSString stringWithFormat :@"%@cash_received.php",DRIVER_BASE_URL])

#define driver_logout_API ([NSString stringWithFormat :@"%@driver_logout.php",DRIVER_BASE_URL])

#define started_triplist_API ([NSString stringWithFormat :@"%@started_trips.php",DRIVER_BASE_URL])

@end
