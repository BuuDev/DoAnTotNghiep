<!DOCTYPE HTML>
<html lang="sv">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="x-apple-disable-message-reformatting" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="color-scheme" content="light dark" />
    <meta name="supported-color-schemes" content="light dark" />
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <style type="text/css" rel="stylesheet" media="all">
        /* Base ------------------------------ */
        
        @import url("https://fonts.googleapis.com/css?family=Nunito+Sans:400,700&display=swap");
        body {
          width: 100% !important;
          height: 100%;
          margin: 0;
          -webkit-text-size-adjust: none;
        }
        
        a {
          color: #3869D4;
        }
        
        a img {
          border: none;
        }
        
        td {
          word-break: break-word;
        }
        
        .preheader {
          display: none !important;
          visibility: hidden;
          mso-hide: all;
          font-size: 1px;
          line-height: 1px;
          max-height: 0;
          max-width: 0;
          opacity: 0;
          overflow: hidden;
        }
        /* Type ------------------------------ */
        
        body,
        td,
        th {
          font-family: "Nunito Sans", Helvetica, Arial, sans-serif;
        }
        
        h2 {
          margin-top: 0;
          color: #333333;
          font-size: 16px;
          font-weight: bold;
          text-align: left;
        }
        
        h3 {
          margin-top: 0;
          color: #333333;
          font-size: 14px;
          font-weight: bold;
          text-align: left;
        }
        
        td,
        th {
          font-size: 16px;
        }
        
        p,
        ul,
        ol,
        blockquote {
          margin: .4em 0 1.1875em;
          font-size: 14px;
          line-height: 1.625;
        }
        
        p.sub {
          font-size: 10px;
          color: #6B6E76;
          line-height: 130%;
          opacity: 0.5;
        }
        /* Utilities ------------------------------ */
        
        .align-right {
          text-align: right;
        }
        
        .align-left {
          text-align: left;
        }
        
        .align-center {
          text-align: center;
        }
        /* Buttons ------------------------------ */
        
        .button {
          background-color: #91C05A;
          border-top: 10px solid #91C05A;
          border-right: 18px solid #91C05A;
          border-bottom: 10px solid #91C05A;
          border-left: 18px solid #91C05A;
          display: inline-block;
          color: white;
          text-decoration: none;
          text-align: center;
          border-radius: 5px;
          box-shadow: 0 2px 3px rgba(0, 0, 0, 0.16);
          -webkit-text-size-adjust: none;
          box-sizing: border-box;
        }
        
        .button--green {
          background-color: #22BC66;
          border-top: 10px solid #22BC66;
          border-right: 18px solid #22BC66;
          border-bottom: 10px solid #22BC66;
          border-left: 18px solid #22BC66;
        }
        
        .button--red {
          background-color: #FF6136;
          border-top: 10px solid #FF6136;
          border-right: 18px solid #FF6136;
          border-bottom: 10px solid #FF6136;
          border-left: 18px solid #FF6136;
        }
        
        /* @media only screen and (max-width: 500px) {
          .button {
            width: 100% !important;
            text-align: center !important;
          }
        } */
        
        body {
          background-color: #F4F4F7;
          color: #000000;
        }
        
        p {
          color: #000000;
        }
        
        /* p.sub {
          color: #6B6E76;
        } */
        
        .email-wrapper {
          width: 100%;
          margin: 0;
          padding: 0;
          -premailer-width: 100%;
          -premailer-cellpadding: 0;
          -premailer-cellspacing: 0;
          background-color: #F4F4F7;
        }
        
        .email-content {
          width: 600px;
          margin: 0 auto;
          padding: 0;
          -premailer-width: 100%;
          -premailer-cellpadding: 0;
          -premailer-cellspacing: 0;
        }
        .email-masthead {
          padding: 10px 0;
          text-align: center;
        }
        
        .email-masthead_logo {
          width: 94px;
        }
        
        .email-masthead_name {
          font-size: 16px;
          font-weight: bold;
          color: #A8AAAF;
          text-decoration: none;
          text-shadow: 0 1px 0 white;
        }
        /* Body ------------------------------ */
        
        .email-body {
          width: 100%;
          margin: 0 ;
          padding: 0;
          -premailer-width: 100%;
          -premailer-cellpadding: 0;
          -premailer-cellspacing: 0;
          background-color: #FFFFFF;
        }
        
        .email-body_inner {
          width: 600px;
          padding: 0;
          -premailer-width: 570px;
          -premailer-cellpadding: 0;
          -premailer-cellspacing: 0;
          background-color: #FFFFFF;
        }
        
        .email-footer {
          width: 100%;
          margin: 0 auto;
          background-color: #595959 !important;
          padding: 0;
          -premailer-width: 570px;
          -premailer-cellpadding: 0;
          -premailer-cellspacing: 0;
          text-align: center;
        }
        
        .email-footer p {
          color: #FFFFFF;
        }
        
        .body-action {
          width: 100%;
          margin: 30px auto;
          padding: 0;
          -premailer-width: 100%;
          -premailer-cellpadding: 0;
          -premailer-cellspacing: 0;
          text-align: center;
        }
        
        .body-sub {
          margin-top: 25px;
          padding-top: 25px;
          border-top: 1px solid #EAEAEC;
        }
        
        .content-cell {
          padding: 35px;
        }
        .margrin-bottom {
            height: 60px;
            background-color: #FFF;
        }
        .text-h1 {
            /* H1 */
            font-family: Montserrat;
            font-style: normal;
            font-weight: bold;
            font-size: 22px;
            line-height: 33px;
            /* or 150% */
            letter-spacing: -1px;
            /* Tertiary Colour 3 */
            color: #415584;

        }
        .text-body {
            position: static;
            /* Body */

            font-family: Montserrat;
            font-style: normal;
            font-weight: normal;
            font-size: 12px;
            /* line-height: 50px; */
            /* or 20px */


            /* Tertiary Colour 3 */

            color: #415584;


            /* Inside auto layout */

            flex: none;
            order: 0;
            flex-grow: 0;
            margin: 32px 0px;
        }
    </style>
</head>
<body>
<table class="email-wrapper" width="100%" cellpadding="0" cellspacing="0" role="presentation">
      <tr>
        <td align="center">
          <table class="email-content" width="100%" cellpadding="0" cellspacing="0" role="presentation">
            <tr style="background: #5A85F4;">
              <td class="email-masthead">
                  <img style="width: auto;height: 100%;float: left;padding: 29.5px 24px;" src="{{url('/image/Logo_SkinDetective_White.png')}}"/>
              </td>
            </tr>
            <!-- Email Body -->
            <tr>
                <td class="email-body" width="100%" cellpadding="0" cellspacing="0">
                    <table class="email-body_inner" align="center" width="570" cellpadding="0" cellspacing="0" role="presentation">
                        <tr>
                            <td class="content-cell">
                                <div class="f-fallback">
                                    <div class="text-h1">
                                        <span>Đặt lại mật khẩu</span>
                                    </div>
                                    <div class="text-body">
                                        <span>Xin chào,</span>
                                        <br /> 
                                        <span style="line-height: 50px;">Cảm ơn bạn đã chọn ứng dụng SkinDetective.</span>
                                        <br /> 
                                        <span>Mã OTP đặt lại mật khẩu cho tài khoản SkinDetective liên kết với email {{$email}} của bạn là:</span>
                                        <br /> 
                                        <span style="font-weight: bold;font-size: 22px;line-height: 50px;">{{$otp}}</span>
                                        <br /> 
                                        <span style="line-height: 50px;">Thời hạn xác nhận: 1 tiếng kể từ khi nhận được email.</span>
                                        <br /> 
                                        <span>SkinDetective.</span>
                                    </div>
                                    
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
</body>
</html>