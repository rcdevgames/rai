import 'dart:convert';

import 'package:RAI/src/models/help.dart';

class Static {
  // General
  static const String APP_NAME = "OneUp";

  // API
  static const String JAVA_URL = "http://129.213.184.154/rai/";

  // Dev
  static const String MCS_URL = "https://E0173A94EDA9476B95743126BF663FED.mobile.ocp.oraclecloud.com:443/mobile/custom/RAI/rai/";
  static const String REGISTER_URL = "https://E0173A94EDA9476B95743126BF663FED.mobile.ocp.oraclecloud.com:443/mobile/platform/devices/register";
  static const String OAUTH_URL = "https://idcs-98c6f5b2de264ab9bab089f2d5a44f31.identity.oraclecloud.com/oauth2/v1/token";

  static const String OAUTHTTOKENENDPOINT = 'https://idcs-98c6f5b2de264ab9bab089f2d5a44f31.identity.oraclecloud.com/oauth2/v1/token';
  static const String OAUTHSCOPE = 'https://E0173A94EDA9476B95743126BF663FED.mobile.ocp.oraclecloud.com:443urn:opc:resource:consumer::all';

  // static const String TOKENOAUTH = "ZThkZTQ0ZWZkMDlkNGRjYWI1ZDZmMThiOTMxZTNhNTQ6ZjQwZjlhYmQtNTg2ZC00MjBkLWE3YWQtMTM1MzUwNTFkMDA3";

  static const String CLIENTID = "e8de44efd09d4dcab5d6f18b931e3a54"; 
  static const String CLIENTSECRET = "f40f9abd-586d-420d-a7ad-13535051d007";
  
  // UAT
  static const String UAT_MCS_URL = "https://E0173A94EDA9476B95743126BF663FED.mobile.ocp.oraclecloud.com:443/mobile/custom/RAIUAT/rai/";
  static const String UAT_REGISTER_URL = "https://8A5D210F6BD34357BCFA3BC0C26C3F6C.mobile.ocp.oraclecloud.com:443/mobile/platform/devices/register";
  static const String UAT_OAUTH_URL = "https://idcs-98c6f5b2de264ab9bab089f2d5a44f31.identity.oraclecloud.com/oauth2/v1/token";

  static const String UAT_OAUTHTTOKENENDPOINT = 'https://idcs-98c6f5b2de264ab9bab089f2d5a44f31.identity.oraclecloud.com/oauth2/v1/token';
  static const String UAT_OAUTHSCOPE = 'https://E0173A94EDA9476B95743126BF663FED.mobile.ocp.oraclecloud.com:443urn:opc:resource:consumer::all';

  // static const String UAT_TOKENOAUTH = "ZThkZTQ0ZWZkMDlkNGRjYWI1ZDZmMThiOTMxZTNhNTQ6ZjQwZjlhYmQtNTg2ZC00MjBkLWE3YWQtMTM1MzUwNTFkMDA3";

  static const String UAT_CLIENTID = "2505f5fafeb7437e96e3397e3255a510"; 
  static const String UAT_CLIENTSECRET = "0d2c7424-f10b-4712-b9e1-dc7e5df73fa9";
  
  // Production
  static const String PROD_MCS_URL = "https://D43098C4B31048B1BB0A6578E6A489CF.mobile.ocp.oraclecloud.com:443/mobile/custom/RAI/rai/";
  static const String PROD_REGISTER_URL = "https://D43098C4B31048B1BB0A6578E6A489CF.mobile.ocp.oraclecloud.com:443/mobile/platform/devices/register";
  static const String PROD_OAUTH_URL = "https://idcs-98c6f5b2de264ab9bab089f2d5a44f31.identity.oraclecloud.com/oauth2/v1/token";

  static const String PROD_OAUTHTTOKENENDPOINT = 'https://idcs-3d71481e2dc346c1b5d929ab3c4f3962.identity.oraclecloud.com/oauth2/v1/token';
  static const String PROD_OAUTHSCOPE = 'https://D43098C4B31048B1BB0A6578E6A489CF.mobile.ocp.oraclecloud.com:443urn:opc:resource:consumer::all';

  // static const String PROD_TOKENOAUTH = "ZThkZTQ0ZWZkMDlkNGRjYWI1ZDZmMThiOTMxZTNhNTQ6ZjQwZjlhYmQtNTg2ZC00MjBkLWE3YWQtMTM1MzUwNTFkMDA3";

  static const String PROD_CLIENTID = "8e3186574f834bbbbd6868e228cc99b2"; 
  static const String PROD_CLIENTSECRET = "6c708a5d-9cc1-4f3c-8c8b-b2037c5c4722";

  
  static const String SENDERID = "843895122652";
  static const String DEFAULT_PASSWORD = "Welcome123456"; 

  static const List<Map<String, String>> LIST_TOUR = [
    {
      'title': '1',
      'description': 'Welcome to OneUp, we can help you save better with more flexibility.',
      // 'imgSrc': 'css/images/dashboard_image@2x.png',
      'color': '#4493cd'
    },
    {
      'title': '2',
      'description': 'Decide the amount you\'d like to save.',
      // 'imgSrc': 'css/images/maps_image@2x.png',
      'color': '#FFD603'
    },
    {
      'title': '3',
      'description': 'Choose the deposit that\'s best for you.',
      // 'imgSrc': 'css/images/incidents_image@2x.png',
      'color': '#E5003E'
    },
    {
      'title': '4',
      'description': 'Watch your savings grow to maturity.',
      // 'imgSrc': 'css/images/customers_image@2x.png',
      'color': '#009636'
    },
    {
      'title': '5',
      'description': 'Need your money back early? Explore our Switch Out options.',
      // 'imgSrc': 'css/images/customers_image@2x.png',
      'color': '#009636'
    },
    {
      'title': '6',
      'description': 'Explore attactive offers from the OneUp community',
      // 'imgSrc': 'css/images/customers_image@2x.png',
      'color': '#009636'
    }
  ];

  static List<Help> LIST_HELP = helpFromJson(json.encode([{"categoryName":"Making deposits","articles":[{"id":1,"title":"How do I make a Time Deposit?","body":"Simply navigate to the 'Deposit Offers' screen in the OneUp App. Enter the amount you would like to switch up and select the length of time you would like to save for. Once this is complete, click Confirm Deposit.\n\nNote: you will need to have sufficient balance available in your External Linked Accounts - please see the relevant section below.\n\nEach Time Deposit can be as little as GBP100 and there is no maximum limit.\n\nThere is also no limit to what you can save with OneUp."},{"id":2,"title":"What does Period Mean?","body":"Period is the length of time for which the published interest rate is guaranteed for the Time Deposit you have made. At the end of the period you will receive back the original amount deposited plus interest calculated according to the Deposit Interest Rate. This amount will be credited to your 'Default' External Linked Account."}]},{"categoryName":"Managing deposits","articles":[{"id":1,"title":"What does AER mean?","body":"AER is short for Annual Equivalent Rate. You will see AER quoted on Savings Accounts provided by a wide range of Banks and other providers - this allows you to compare interest rates across these different providers."},{"id":2,"title":"What does Gross Interest mean?","body":"Gross Interest is the annual rate of interest you will get before any charges or taxes are deducted. Gross Interest is usually shown as a percentage rate. Depending on your circumstances OneUp may be obliged by HMRC to withhold income tax on interest."},{"id":3,"title":"What do I do when my deposit matures?","body":"The day after your deposit matures e.g. 6, 9 or 12 months after you make your deposit, you will receive back the original amount deposited (often called 'Principal') and the interest you have earned. This combined amount will be automatically credited to your External Linked Account. If you have two or more External Linked Accounts, it will be credited to the 'Default' External Linked Account."}]},{"categoryName":"Switch Outs","articles":[{"id":1,"title":"What is a Switch Out?","body":"When you make a deposit you choose the period of time for which an interest rate is guaranteed. Typically the longer you agree to deposit your money for, the higher the interest rate you will receive. However sometimes you may wish to withdraw some or all of your money from your deposit earlier than the deposit maturity date.\n\nOneUp uses an innovative way of matching full or partial withdrawals from a Time Deposit by one OneUp member with a new deposit by another OneUp member which allows you to preserve as much of your earned interest as possible."},{"id":2,"title":"How do I make a Switch Out ?","body":"All your deposits are listed in the My Money tab of the OneUp app. Tapping a deposit will show details of the deposit e.g. maturity date, interest rate, amount deposited etc. At the bottom of this Deposit Details screen you will see Explore Switch Out Options. Click this button and choose how much of your deposit you wish to withdraw."},{"id":3,"title":"How is my interest calculated in a Switch Out?","body":"If you trigger a Switch Out, the OneUp App will try to match your withdrawal with a new deposit over the next 30 days.\n\nIf a match occurs in the first 7 days you will receive all of your original deposit, plus all of the interest which you earned up to the point in time when you triggered a Switch Out.\n\nIf a match occurs between 8 and XX days, we will deduct a small proportion of the interest you have earned to date in order to incentivise a new depositor.\n\nThis process continues with the proportion of interest deducted gradually increasing each week in order to help you find a deposit match.\n\nIf in the event that no matching depositor can be found before 30 days has passed, we will repay your original deposit but with the High Street interest rate applied to it rather than the Deposit Interest rate defined when you made your original deposit. This means that in a worse case scenario where no deposit match can be found, you will still receive an interest rate broadly equivalent to that which your funds would have attracted if they had been left in a High Street Bank Current account."},{"id":4,"title":"What is the 'High Street' Interest Rate?","body":"High Street Interest rate is a rate calculated to be the average of that which applies to standard current accounts provided by the Big 4 Banks in the UK. Please see details here on how this rate is calculated."},{"id":5,"title":"Can I cancel an Switch Out request if I choose to?","body":"So long as a Switch Out match has not already occurred you can cancel a Switch Out at any time. Simply navigate to the Deposit in question via the My Money tab, and click the 'My Switch Outs' tab. You can identify Deposits for which a Switch Out is live by the 'Switch Out' text in the top right corner of the Deposit Summary.\n\nIf an Switch Out request is cancelled, then the deposit will continue to perform as though the Switch Out 0request had never been made."},{"id":6,"title":"Am I limited in how many Deposits or Switch Outs I can make?","body":"TBD"}]},{"categoryName":"Linked Accounts","articles":[{"id":1,"title":"What is an External Linked Account?","body":"An External Linked Account is a Bank Account account which you control, but which is provided by another Bank. Using industry standard technology and only if you allow us to, we are able to securely request the balance of your External Account. This helps you see in one place how much money which may be only attracting very low rates of interest. If you allow us, and specifically authorise within the OneUp app, we can trigger a transfer of cash from your external account to OneUp in order to easily complete your Deposit."},{"id":2,"title":"How do I link an External Account?","body":"The linking of External Accounts are simulated in the Alpha version of OneUp. More details of how to link accounts (using Open Banking Standards) will be provided in due course."},{"id":3,"title":"What does 'Default External LInked Account' mean?","body":"Your Default External Linked Account is the account which will be used as the source of funds for any new deposits, and as the account to which any maturing deposits, or proceeds from Switch Out, are credited.\n\nYou can see a list of your External Linked Accounts in the Linked Accounts section of the My Profile tab of the OneUp app. Swiping the account allows you to edit details and change default preferences."}]},{"categoryName":"Terms and Conditions","articles":[{"id":1,"title":"Terms and Conditions","body":"TBD"},{"id":2,"title":"How we keep your data safe?","body":"TBD"}]}]));





  // Error Message
  static const String ERROR_GENERIC = "Unexpected system error";
  static const String ERROR_UNAUTHORIZED = "Your session is expired, you will be redirected to login page";
  static const String ERROR_LOGIN = "You entered an incorrect 6 digit code";
}