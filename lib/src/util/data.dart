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
      'color': '#4493cd'
    },
    {
      'title': '2',
      'description': 'Decide the amount you\'d like to save.',
      'color': '#FFD603'
    },
    {
      'title': '3',
      'description': 'Choose the deposit that\'s best for you.',
      'color': '#E5003E'
    },
    {
      'title': '4',
      'description': 'Watch your savings grow to maturity.',
      'color': '#009636'
    },
    {
      'title': '5',
      'description': 'Need your money back early? Explore our Switch Out options.',
      'color': '#009636'
    },
    {
      'title': '6',
      'description': 'Explore attactive offers from the OneUp community.',
      'color': '#009636'
    }
  ];

  static List<Help> LIST_HELP = helpFromJson(json.encode(
      [
        {
          'categoryName': 'Terms and Conditions',
          'articles': [
            {
              'id': 1,
              'title': 'What is our agreement?',
              'body':
              "This agreement is between us, Standard Chartered Bank, and you, the person we are opening and operating an account for.\n\nOur agreement is split into two sections – Our Relationship Terms and Your Account Terms. The full details of our agreement are set out in the sections below, and by using this app, you agree to the terms of this agreement.\n\nThis agreement is a legal document and it is governed by English law. If there are any disputes that arise out of our agreement, they will be settled by the English courts.",
            },
            {
              'id': 2,
              'title': 'Where can you find this agreement?',
              'body':
              "The agreement can be accessed at any time within the app under the Help tab. You may separately request a paper copy of this agreement.",
            },
          ],
        },
        {
          'categoryName': 'Our Relationship Terms',
          'articles': [
            {
              'id': 1,
              'title': 'Who are we?',
              'body':
              "Standard Chartered Bank is a leading international bank.\n\nStandard Chartered Bank is incorporated in England with limited liability by Royal Charter 1853 Reference Number ZC18 and the registered office is at 1 Basinghall Avenue, London EC2V 5DD. Standard Chartered Bank is authorised by the Prudential Regulation Authority and regulated by the Financial Conduct Authority and the Prudential Regulation Authority.",
            },
            {
              'id': 2,
              'title': 'Can you enter into this agreement?',
              'body':
              "You will need to meet certain eligibility criteria in order to enter into this agreement, including that:\n\n- You are an individual, as opposed to a company\n- You are UK resident, and at least 18 years of age",
            },
            {
              'id': 3,
              'title': 'How can you get in touch?',
              'body':
              "You can contact us by email at oneup@sc.com\n\nWe will communicate with you in English unless we agree otherwise."
            },
            {
              'id': 4,
              'title': 'How will we get in touch with you?',
              'body':
              "We will contact you by email or phone\n\nYou will also receive push notifications when the app performs certain tasks."
            },
            {
              'id': 5,
              'title': 'How do we use the information you give us?',
              'body':
              "We use the information you give us in order to provide the services we agree to provide you under this agreement. This includes using your information to facilitate transfers into and out of your account.\n\nWe may also send your information to third parties in order to run credit reference and fraud prevention checks.\n\nBy using the app and agreeing to these terms, you consent to us using your information in this way, but if at any point you change your mind, we will have to close your account. We may keep your information after we close your account if we have lawful grounds to do so.\n\nOur [Data Privacy Notice] explains this in more detail."
            },
            {
              'id': 6,
              'title': 'How do we comply with tax obligations?',
              'body':
              "We may be required by law or regulation to share information about your accounts with UK and foreign tax authorities.\n\nIf we need extra documents or information from you about this, you must supply these, otherwise we may need to close your account. We may also be required to withhold certain funds from your account and pay these to the relevant tax authorities in certain circumstances. We will let you know as soon as possible if we are required to do this."
            },
            {
              'id': 7,
              'title': 'How do you make a complaint?',
              'body':
              "If you have a complaint, please contact us and we will do our best to fix the problem.\n\nIf you are still not happy, you can refer your complaint to the Financial Ombudsman Service. For more details you can visit their website.\n\nYou can also submit your complaint through the European Commission’s Online Dispute Resolution website. The European Commission may then refer your complaint to the Financial Ombudsman Service. You can find more information ​here. "
            },
            {
              'id': 8,
              'title': 'How is your money protected?',
              'body':
              "Up to £85,000 in your account is protected (per depositor, not per account) by the Financial Services Compensation Scheme (FSCS). For more information about the FSCS, including amounts covered and eligibility, you can visit their website: www.fscs.org.uk."
            },
            {
              'id': 9,
              'title': 'What happens if there is something wrong with our agreement?',
              'body':
              "If any term of our agreement is unlawful or unenforceable, this will not affect the rest of our agreement, which will continue in full force.\n\nIf we do not insist that you perform your obligations under our agreement, it does not mean you do not have to. If we choose not to exercise our rights immediately, this does not constitute a waiver of our rights and we may choose to do so at a later date."
            },
          ],
        },
        {
          'categoryName': 'Protecting Your Account',
          'articles': [
            {
              'id': 1,
              'title': 'What security measures are taken so we can ensure your account is secure?',
              'body':
              "Before we do certain things (e.g. provide information about your account or facilitate transfers) we need to ensure that you are providing the instructions.\n\nYou will need to have your touch ID enabled on your iPhone\n\nWhen you first log into the App, you will be asked for a 6 digit code, which you will receive by email. Thereafter you will only need touch ID verification. Every time you reinstall the App however, you will need to enter this code.\n\nYou must do all you reasonably can to keep your code safe. In future, we will migrate to passwords. Do not choose a password that is easy for someone else to guess and do not give it to anyone else or do anything that would let someone else use them.",
            },
            {
              'id': 2,
              'title': 'How will we keep you updated on the activity of your account?',
              'body': "You can see the details of your transactions and your deposits on the app. From time to time you may also receive notifications. In future we will introduce features to provide statements of your deposits.",
            },
          ],
        },
        {
          'categoryName': 'Depositing Money With Us',
          'articles': [
            {
              'id': 1,
              'title': 'What are Linked Accounts?',
              'body':
              'You link your existing checking or savings accounts with other UK banks to this account to make them a “Linked Account”. Linked Accounts can only be UK-based sterling accounts at this time. If you have more than one Linked Account, you will select one as your “Default Linked Account”\n\nBy providing details of your Linked Accounts you consent to SCB acting as an AISP and PISP and you consent to your having access to the account information (login and passwords) necessary to (i) show balances and (ii) direct payments from the accounts into the app',
            },
            {
              'id': 2,
              'title': 'How can you deposit money into your account?',
              'body':
              "You can deposit money into your account directly through the app.\n\n- Deposit money through the “Deposit Offers” tab in the app:\n\t\t* Enter the amount you wish to deposit\n\t\t* You will be given a number of “Deposit Offers” – combinations of interest rates and maturities which are available for your deposit\n\t\t* Choose the Deposit Offer which best suits your needs\n\t\t* Choose the Linked Account you wish to transfer it from\n\t\t* Confirm deposit.\n\n- Once you confirm deposit, we will initiate a payment from your selected Linked Account into the account\n\n- You will see notifications on the deposit being placed",
            },
            {
              'id': 3,
              'title': 'Are there any limits on what I can deposit?',
              'body': "No, as long as the deposits are in Pound Sterling.",
            },
            {
              'id': 4,
              'title': 'What happens if we suspect something suspicious is going on?',
              'body':
              "We may block deposits into your account if:\n\n- we suspect there is fraudulent or criminal activity on your account\n\n- by accepting the deposit, we become exposed to legal action by a government or regulator or other state agency\n\nIf we block a deposit, we will let you know as soon as possible.",
            },
            {
              'id': 5,
              'title': 'What is the term of your deposit?',
              'body':
              'Your deposit will have a specific term which will depend on the Deposit Offer you chose when you initially made your deposit. You will always be able to see the term of each of your deposits in the “My Money" tab.',
            },
            {
              'id': 6,
              'title': 'What is the interest rate on the deposit?',
              'body':
              "Unless you exit early, your deposit will pay a fixed interest rate, which will depend on the Deposit Offer you chose when you initialy made your deposit. You will always be able to see the interest rate of each of your deposits in the “My Money” tab. You can lose your accrued interest if you make a Switch Out. See [**].",
            },
            {
              'id': 7,
              'title': 'Can you use this account outside the UK?',
              'body': "You must be a UK resident individual to open and maintain an account with us.",
            },
          ],
        },
        {
          'categoryName': 'Maturity',
          'articles': [
            {
              'id': 1,
              'title': 'What happens at the end of the term deposit?',
              'body': "At the end of the term deposit, the deposited money plus all accrued interest will be transferred to your Default Linked Account. If your Default Linked Account has been closed or we cannot transfer funds to it, we will contact you to request that you nominate another Linked Account. In the meantime, we will continue to hold your money on deposit at the High Street Interest Rate.",
            },
            {
              'id': 2,
              'title': 'How can you reinvest your savings upon maturity?',
              'body': 'Once your deposit has been returned to your Default Linked Account, you can make a new deposit in the same way as you made your original deposit.\n\nIf you select “Remind me to reinvest” in the “My Money" tab for any of your deposits, three days before that deposit is due to mature, we will provide you with Deposit Offers for re-depositing the money you will receive upon maturity of that deposit.',
            },
          ],
        },
        {
          'categoryName': 'Switch Outs',
          'articles': [
            {
              'id': 1,
              'title': 'Can you withdraw your deposit early?',
              'body': 'Yes, but you might not get back all of the interest which has accrued on your account up to that point.\n\nYou achieve this through the “Explore Switch Out Options” function in the "Deposit Detail” page in your app.\n\nYou can only withdraw up to the amount shown as “Total Deposits” in your app.',
            },
            {
              'id': 2,
              'title': 'How does it work?',
              'body': 'Select how much you would like to withdraw from your deposit (it can be some or all of your deposit, in denominations of £100).\n\nYou confirm this withdrawal using the “Confirm Switch Out" button. Once you press this button, you will need to verify your identity [using face/touch ID/your 6-digit code] and the amount you wish to withdraw before the instruction is complete.\n\nWhen you confirm your Switch Out, we create a new Deposit Offer for the amount you have chosen to withdraw with the same features (e.g. term/interest rate) that your deposit has. This new Deposit Offer will be available to other customers.\n\nWe will offer this to customers for 31 days – if no one is willing to accept it, then don’t worry, we will pay your back the original amount you deposited. However, you will lose some or all of your accrued interest. See [**] for further details.\n\nAll repayments of the deposited money will be automatically transferred to your Default Linked Account.',
            },
            {
              'id': 3,
              'title': 'What happens to your deposit on a Switch Out?',
              'body': "If you choose to Switch Out, you will always get back the full amount that you deposited.\n\nYou will get this back at the earlier of the date on which a customer agrees to take on your deposit and 31 calendar days (or the first business day after this period) after you confirm your Switch Out",
            },
            {
              'id': 4,
              'title': 'What happens to your interest on a Switch Out?',
              'body': "If you choose to Switch Out, you may not get back all or any of your accrued interest.\n\nHow much interest you receive depends on whether and when another customer decides to enter into a new deposit on equivalent terms by accepting the newly created Deposit Offer.\n\nWe have given you a summary in this section of how interest is dealt with on a Switch Out but check out the Interest Repayment Table for full details on how this works.\n\nIf we find a new customer within a week of you confirming your Switch Out to take on your deposit, you are entitled to receive the almost the full amount of your accrued interest.\n\nIf over a week has passed since you confirmed your Switch Out and we find a new customer to take your deposit, the amount of accrued interest that you will be owed will reduce in accordance with the amount of time it has taken to find a new customer. Full details on how much this will be reduced by can be found in the Interest Repayment Table.\n\nIf no new customer can be found within 30 days to take your deposit, you will not receive any accrued interest, but you will get back the money you deposited in full. We will however match and provide you with the amount of interest that you would have received from your current checking account during the period.\n\nIf interest rates have increased since you made your deposit, you are more likely to forego some or all of your interest on a Switch Out, since new depositors will be less inclined to take on a deposit on a lower interest rate than that which might be available in the market.",
            },
            {
              'id': 5,
              'title': 'What about interest you would have earned in your Linked Account?',
              'body': "We will always pay you at least the amount of interest that you would have earned for the same period at the High Street Interest Rate. This will be the rate that is publicly advertised by your bank for the general checking account.",
            },
            {
              'id': 6,
              'title': 'When do you get paid the interest you are owed upon a Switch Out?',
              'body': "You will receive any interest you are owed on the date that you would have received your deposit if you had kept it until maturity.\n\nIf you would like to receive it sooner, that’s fine too, although you will receive a little less. Full details on how much this will be reduced by can be found in the Interest Repayment Table.",
            },
            {
              'id': 7,
              'title': 'When will we not allow a Switch Out?',
              'body': "We may block a Switch Out if:\n\n- we suspect there is fraudulent or criminal activity on your account\n\n- we suspect that it has not been confirmed by you\n\n- we suspect that there has been a breach of security or a misuse of your account, security details or the app\n\n - we’re not legally allowed to make it",
            },
          ],
        },
        {
          'categoryName': 'When Things Go Wrong',
          'articles': [
            {
              'id': 1,
              'title': 'How will we deal with unauthorised and mistaken withdrawals?',
              'body': "If a withdrawal is mistakenly made from your account without being properly authorised by you and it is our fault, we will immediately refund you the money.\n\nHowever, you won’t be able to claim back money you’ve lost if:\n\n- you have mistakenly given us the wrong instructions (such as, for example, stating the wrong amount or specifying the wrong Linked Account as your Default Linked Account) and we follow those instructions\n\n- you purposefully didn’t keep your phone or [6-digit code] safe, or you were negligent in not keeping them safe, or you gave them to someone else\n\n- you acted fraudulently\n\n- you acted in breach of this agreement",
            },
            {
              'id': 2,
              'title': 'What happens if a deposit is made in error?',
              'body': "If a deposit is made from one of your Linked Accounts in error into your SCB account and we are responsible for this, we will reverse the transfer immediately. You are requested to contact us immediately. ",
            },
          ],
        },
        {
          'categoryName': 'Changing and Ending Our Agreement',
          'articles': [
            {
              'id': 1,
              'title': 'How will changes be made to our agreement?',
              'body': "We can make changes to our agreement for any reason. ​If we make changes to it that are clearly in your favour, we will tell you once we've made them. Otherwise we will give you two months' notice ​using one of our usual channels​.\n\nIf you do not agree to these changes, you can let us know and we will close your account. We will transfer your deposits to your Default Linked Account, unless you tell us otherwise. If we do not hear from you, we will assume that you are happy with the changes we have made.",
            },
            {
              'id': 2,
              'title': 'How can you end our agreement?',
              'body': "You can let us know if you wish to end the agreement and close your account at any time by getting in touch with us. We will ask you to verify your wish to end the agreement using your touch ID or 6-digit PIN. If you wish to close your account, you will not be able to reopen your account once it has been closed and you must delete the app from your phone.\n\nIf you close your account, you will forfeit all accrued interest, and we will transfer your deposits to your Default Linked Account immediately 31 days upon closure of the account.",
            },
            {
              'id': 3,
              'title': 'How can we end the agreement?',
              'body': "We are entitled to end this agreement and close your account for any reason by giving at least two months’ notice.\n\nIf we provide you with notice that we will end this agreement and close your account, you can choose to Switch Out in the manner outlined above in order to recoup your accrued interest. Otherwise, with 31 days remaining to the date of closure we will trigger Switch Out of the deposit and  we will transfer your deposits to your Default Linked Account immediately upon closure of the account at the end of the notice period.",
            },
          ],
        },
      ]));

  // Error Message
  static const String ERROR_GENERIC = "Unexpected system error";
  static const String ERROR_UNAUTHORIZED = "Your session is expired, you will be redirected to login page";
  static const String ERROR_LOGIN = "You entered an incorrect 6 digit code";
}
