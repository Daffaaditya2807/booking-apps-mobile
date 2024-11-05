String emailTemplate(String name, String kodeOtp) {
  return '''
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTP Verification</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-image: url('https://archisketch-resources.s3.ap-northeast-2.amazonaws.com/vrstyler/1661497957196_595865/email-template-background-banner');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        .content {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .header {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }
        .otp-code {
            font-size: 32px;
            font-weight: bold;
            color: #007bff;
            text-align: center;
            margin: 20px 0;
            letter-spacing: 2px;
        }
        .footer {
            text-align: center;
            margin-top: 20px;
            color: #666;
            font-size: 14px;
        }
        .brand {
            font-weight: bold;
            color: #333;
            font-size: 18px;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="content">
            <div class="header">Kode OTP</div>
            <p>Hey $name,</p>
            <p>Terima kasih telah memilih Antriqu Apps. Gunakan OTP berikut untuk menyelesaikan pembuatan akun email Anda. Silakan kembali ke menu registrasi dan masukkan kode dibawah ini agar akun anda terverifikasi</p>
            <div class="otp-code">$kodeOtp</div>
            <p>Need help? Ask at <a href="mailto:antriquapps@gmail.com">antriquapps@gmail.com</a></p>
            <div class="footer">
                <div class="brand">Antriqu Apps</div>
            </div>
        </div>
    </div>
</body>
</html>
''';
}
