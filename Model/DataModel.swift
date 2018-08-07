//
//  DataModel.swift
//  ADIM
//
//  Created by Ahmed Durrani on 06/10/2017.
//  Copyright © 2017 Expert_ni.halal_Pro. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper


class UserResponse: Mappable {
    
    var success                  :       Bool?
    var message                  :       String?
    var data                     :       UserInformation?
    var requestClientData        :       ServiceRequestObject?
    var notaryProfile            :       NotaryProfile?
    var notaryList               :       [UserInformation]?
    var listOfRequest            :       ClientRequestJob?
    var serviceList              :       [GetAllServiceObject]?
    var addServiceList           :       GetAllServiceObject?
    var reviewList               :       [GetALLReviewObject]?
    var certificateList          :       [GETALLCertificateObject]?
    var uploadCertificate        :       GETALLCertificateObject?
    var notaryAllList            :       NotaryObject?
    var requestDocument          :       NotaryDocumentVerify?
    var isNotaryAcceptOffer      :       NotarySendOfferToClient?
    var cardInfoObject           :       [CardObject]?
    var notaryReport           :       NotaryReportObject?
    var notaryLuanguageList      :     [NotaryLuanguageList]?
    
    
    var error                    :       ErrorObject?
    var passObject               :       ErrorObject?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data    <- map["data"]
        serviceList <- map["data"]
        addServiceList <- map["data"]
        notaryProfile <- map["data"]
        reviewList <- map["data"]
        certificateList <- map["data"]
        uploadCertificate <- map["data"]
        notaryList <- map["data"]
        requestClientData <- map["data"]
        isNotaryAcceptOffer  <- map["data"]
        notaryAllList <- map["data"]
        listOfRequest <- map["data"]
        requestDocument <- map["data"]
        cardInfoObject <- map["data"]
        error   <- map["errors"]
        passObject <- map["password"]
        cardInfoObject <- map["data"]
        
        notaryReport <- map["data"]
        notaryLuanguageList <- map["data"]
        
        
        
    }
}

class ErrorObject : Mappable {
    var email: String?
    var password: String?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        email <- map["errors.email"]
        password <- map["errors.password"]
    }

}

class NotaryObject : Mappable {
    var selectNotaryList: [SelectDayObject]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        selectNotaryList <- map["allList"]
    }
    
}


class SelectDayObject: Mappable {
    var type: String?
    var typeObject: [ServiceRequestObject]?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        type <- map["day"]
        typeObject <- map["data"]
    }
}

class EmailValidator : Mappable {
    
    var user: UserInformation?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        user <- map["user"]
        
    }
    
}

class PhoneNumberValidator : Mappable {
    
    var user: UserInformation?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        user <- map["user"]
        
    }
    
}

class UserData : Mappable {
    
    var user: UserInformation?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        user <- map["user"]
        
    }
    
}

class NotaryReportObject : Mappable {
    var total_sales: Int?
    var current_month: String?
    var sales_in_current_month: Int?
    var sales_in_current_week_of_month: Int?
    var projected_sales_in_next_month: Int?
    var current_appointments: Int?
    var total_customers: Int?
    var new_customers: Int?
    var returning_customers: Int?
    var projected_new_customers: Int?
    var projected_returning_customers: Int?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        total_sales <- map["total_sales"]
        current_month <- map["current_month"]
        sales_in_current_month <- map["sales_in_current_month"]
        sales_in_current_week_of_month <- map["sales_in_current_week_of_month"]
        projected_sales_in_next_month <- map["projected_sales_in_next_month"]
        current_appointments <- map["current_appointments"]
        total_customers <- map["total_customers"]
        new_customers <- map["new_customers"]
        returning_customers <- map["returning_customers"]
        projected_new_customers <- map["projected_new_customers"]
        projected_returning_customers <- map["projected_returning_customers"]

        
    }
    
}

class NotaryLuanguageList : Mappable {
    var id: Int?
    var user_id: Int?
    var language_name: String?
    var prefered: Int?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        user_id <- map["user_id"]
        language_name <- map["language_name"]
        prefered <- map["prefered"]
        
        
    }
    
}

class CardObject : Mappable {
    var user_id: Int?
    var card_holder_name: String?
    var card_number: String?
    var expiration_month: String?
    var expiration_year: String?
    var cvv: String?
    var clientProfile : UserInformation?
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        user_id <- map["user_id"]
        card_holder_name <- map["card_holder_name"]
        card_number <- map["card_number"]
        expiration_month <- map["expiration_month"]
        expiration_year <- map["expiration_year"]
        cvv <- map["cvv"]
        clientProfile <- map["user"]

    }
    
}

class NotaryDocumentVerify : Mappable {
    
    var id: Int?
    var request_ids : String?
    var request_id: Int?
    var name: String?
    var url: String?
    var verified: Bool?
    var verified_url : String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        request_id <- map["request_id"]
        request_ids <- map["request_id"]
        name <- map["name"]
        url <- map["url"]
        verified <- map["verified"]
        verified_url <- map["verified_url"]
    }
}



class UserInformation : Mappable {
    
    var id: Int?
    var apiToken: String?
    var username: String?
    var email: String?
    var phone_no: String?
    var type : String?
    var address : String?
    var zipCode : String?
    var lat     : Int?
    var lng     : Int?
    var deviceToken : String?
    var created : String?
    var avatar_url : String?
    var reviewList                       :       [GetALLReviewObject]?
    var notaryCertificates               :       [GETALLCertificateObject]?
    var notaryProfile                    :       NotaryProfileObject?
    var ratedNotary                      :       [RatingObject]?
    var  paymentInfo                     :       CardObject?
    



    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        apiToken <- map["api_token"]
        username <- map["name"]
        phone_no <- map["phone_no"]
        email <- map["email"]
        type <- map["type"]
        address <- map["address"]
        lat <- map["latitude"]
        lng <- map["longitude"]
        deviceToken <- map["device_token"]
        created <- map["created_at"]
        avatar_url <- map["avatar_url"]
        zipCode <- map["zip_code"]
        reviewList <- map["reviews"]
        notaryCertificates <- map["notary_certificates"]
        notaryProfile  <- map["notary_profile"]
        paymentInfo    <- map["user_payment_card"]
        
        
    }
}


class NotaryProfileObject : Mappable {
    
    var id: Int?
    var user_id: String?
    var notary_type: String?
    var commission_no: String?
    var surety_bond_information: String?
    var e_and_o_insurance : String?
    var suggested_fees_for_services : Int?
    var delivery_charges : Int?
    var notary_qualifications     : String?
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        user_id <- map["user_id"]
        notary_type <- map["notary_type"]
        commission_no <- map["commission_no"]
        surety_bond_information <- map["surety_bond_information"]
        e_and_o_insurance <- map["e_and_o_insurance"]
        suggested_fees_for_services <- map["suggested_fees_for_services"]
        delivery_charges <- map["delivery_charges"]
        notary_qualifications <- map["notary_qualifications"]
        
    }
}

class RatingObject : Mappable {
    
    var average: String?
    var ratee_id: Int?
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        average <- map["average"]
        ratee_id <- map["ratee_id"]
        
    }
}



class ClientRequestJob : Mappable {
    var listOfClientCompleteJob : [ServiceRequestObject]?
    var listOfClientPendinfJob : [ServiceRequestObject]?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        
        listOfClientCompleteJob <- map["completed"]
        listOfClientPendinfJob <- map["pending"]
    }
}





class NotaryProfile : Mappable {
    var notaryUserID : Int?
    var notary_type: String?
    var commission_no: String?
    var activation_date: String?
    var expiration_date: String?
    var surety_bond_information: String?
    var e_and_o_insurance : String?
    var suggested_fees_for_services : String?
    var delivery_charges : String?
    var user_id     : Int?
    var notary_qualifications : String?
    var created_at : String?
    var userProfile : UserInformation?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        notaryUserID <- map["id"]
        notary_type <- map["notary_type"]
        commission_no <- map["commission_no"]
        activation_date <- map["activation_date"]
        expiration_date <- map["expiration_date"]
        surety_bond_information <- map["surety_bond_information"]
        e_and_o_insurance <- map["e_and_o_insurance"]
        suggested_fees_for_services <- map["suggested_fees_for_services"]
        delivery_charges <- map["delivery_charges"]
        user_id <- map["user_id"]
        notary_qualifications <- map["notary_qualifications"]
        created_at <- map["created_at"]
        userProfile <- map["user"]
    }
}



class GetAllServiceObject : Mappable {
    var serviceId : Int?
    var user_id: String?
    var name: String?
    var price: String?
    var prices: Int?

    var slug: String?
    var created_at: String?
    var updated_at: String?
    var deleted_at : String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        serviceId <- map["id"]
        user_id <- map["user_id"]
        name <- map["name"]
        slug <- map["slug"]
        price <- map["price"]
        prices <- map["price"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
    }
}

class GetALLReviewObject : Mappable {
    var idOfReview : Int?
    var rater: String?
    var rater_id: Int?
    var ratee: String?
    var ratee_id: Int?
    var rating: Int?
    var comment: String?
    var created_at : String?
    var updated_at : String?

    
    var notaryReview : GETALLNotaryObjectReview?
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        
        idOfReview <- map["id"]
        rater <- map["rater"]
        rater_id <- map["rater_id"]
        ratee <- map["ratee"]
        ratee_id <- map["ratee_id"]
        rating <- map["rating"]
        comment <- map["comment"]
        notaryReview <- map["notary"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]

        
    }
}

class GETALLNotaryObjectReview : Mappable {
    var idOfNotary : Int?
    var name: String?
    var email: Int?
    var notaryReview : [GetAllNotaryReview]?
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        
        idOfNotary <- map["id"]
        name <- map["name"]
        email <- map["email"]
        notaryReview <- map["rating"]
    }
}

class GetAllNotaryReview : Mappable {
   
    var ratee_id : Int?
    var average: String?
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        
        ratee_id <- map["ratee_id"]
        average <- map["average"]
    }
}

class GETALLCertificateObject : Mappable {
    var idOfCertificate : Int?
    var name: String?
    var updated_at: Int?
    var url : String?
    var user_id : Int?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        
        idOfCertificate <- map["id"]
        name <- map["name"]
        updated_at <- map["updated_at"]
        url <- map["url"]
        user_id <- map["user_id"]

    }
}


class ServiceRequestObject : Mappable {
    var id        : Int?
    var client_id : Int?
    var notary_id: Int?
    var service_id: String?
    var company_name: String?
    var business_email: String?
    var address: String?
    var latitude : Double?
    var longitude : Double?
    var on_going : String?
    var payment_type     : String?
    var status : String?
    var created_at : String?
    var appointment : String?
    var appointmentDate              : AppointmentDateObject?
    var clientObj                    : UserInformation?
    var clientGetNotaryObject        : UserInformation?
    var doucmentList                 : [DocuemtnObject]?


    var documentObject : [DocuemtnObject]?
   
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id        <- map["id"]
        client_id <- map["client_id"]
        notary_id <- map["notary_id"]
        service_id <- map["service_id"]
        company_name <- map["company_name"]
        business_email <- map["business_email"]
        address <- map["address"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        on_going <- map["on_going"]
        payment_type <- map["payment_type"]
        status <- map["status"]
        appointment <- map["appointment_datetime"]
        
        created_at <- map["created_at"]
        appointmentDate <- map["appointment_datetime"]
        documentObject  <- map["documents"]
        clientObj       <- map["client"]
        documentObject <- map["documents"]
        clientGetNotaryObject <- map["notary"]
        
        
    }
}


class NotarySendOfferToClient : Mappable {
    var client_request_id : String?
    var client_id: Int?
    var notary_id: Int?
    var offer_details: String?
    var offer_date: String?
    
    var documentObject : [DocuemtnObject]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        client_request_id <- map["client_request_id"]
        client_id <- map["client_id"]
        notary_id <- map["notary_id"]
        offer_details <- map["offer_details"]
        offer_date <- map["offer_date"]
    }
}

class AppointmentDateObject : Mappable {
    
    var date : String?
    var timezone: String?
    var timezone_type : Int?
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        
        date <- map["date"]
        timezone <- map["timezone"]
        timezone_type <- map["timezone_type"]

    }
}

class DocuemtnObject : Mappable {
    
    var created_at : String?
    var idofDocument: Int?
    var name : String?
    var request_id : Int?
    var url : String?
    var verified : Bool?
    var verified_url : String?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        
        created_at <- map["created_at"]
        idofDocument <- map["id"]
        name <- map["name"]
        request_id <- map["request_id"]
        url <- map["url"]
        verified <- map["verified"]
        verified_url <- map["verified_url"]
        
        

        
    }
}

