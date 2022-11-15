
let templateEmail = () => `<table width="100%" cellpadding="0" cellspacing="0" role="presentation" style="width:100%;background-color:#f4f4f7;margin:0;padding:0" bgcolor="#F4F4F7">
<tbody><tr>
  <td align="center" style="word-break:break-word;font-family:'Inter',Helvetica,Arial,sans-serif;font-size:16px">
    <table width="100%" cellpadding="0" cellspacing="0" role="presentation" style="width:100%;margin:0;padding:0">
      <tbody><tr>
        <td align="center"  style="word-break:break-word;font-family:'Inter',Helvetica,Arial,sans-serif;font-size:16px;text-align:center;background-color:#fff;padding:25px 0" bgcolor="#fff">
          <img src="{{image}}" width="566" style="width:566px" class="CToWUd" data-bit="iit">
        </td>
      </tr>
      
      <tr>
        <td  width="100%" cellpadding="0" cellspacing="0" style="word-break:break-word;font-family:'Inter',Helvetica,Arial,sans-serif;font-size:16px;width:100%;background-color:#ffffff;margin:0;padding:0" bgcolor="#FFFFFF">
          <table align="center" width="570" cellpadding="0" cellspacing="0" role="presentation" style="width:570px;background-color:#ffffff;margin:0 auto;padding:0" bgcolor="#FFFFFF">
            
            <tbody><tr>
              <td  style="word-break:break-word;font-family:'Inter',Helvetica,Arial,sans-serif;font-size:16px;padding:35px">
                <div>
                  <h1 style="margin-top:0;color:#333333;font-size:22px;font-weight:bold;text-align:left" align="left">Welcome {{username}} to Meal Dash!</h1>
<p style="font-size:16px;line-height:1.625;color:#51545e;margin:.4em 0 1.1875em">We’re thrilled to have you on board.</p><p style="font-size:16px;line-height:1.625;color:#51545e;margin:.4em 0 1.1875em">
</p><p style="font-size:16px;line-height:1.625;color:#51545e;margin:.4em 0 1.1875em">
Your verification code is {{security_code}}
</p>


<table align="center" width="100%" cellpadding="0" cellspacing="0" role="presentation" style="width:100%;text-align:center;margin:30px auto;padding:0">
<tbody><tr>
  <td align="center" style="word-break:break-word;font-family:'Inter',Helvetica,Arial,sans-serif;font-size:16px">
    
    <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
      <tbody><tr>
        <td align="center" style="word-break:break-word;font-family:'Inter',Helvetica,Arial,sans-serif;font-size:16px">
          <a href="" style="color:#fffafa;background-color:#c049ff;display:inline-block;text-decoration:none;border-radius:3px;box-sizing:border-box;border-color:#c049ff;border-style:solid;border-width:10px 18px" target="_blank">
            <span>{{security_code}}</span>
          </a>
        </td>
      </tr>
    </tbody></table>
  </td>
</tr>
</tbody></table>
<p style="font-size:16px;line-height:1.625;color:#51545e;margin:.4em 0 1.1875em">Thanks,
<br>Your friends at Meal-Dash</p>
<p style="font-size:16px;line-height:1.625;color:#51545e;margin:.4em 0 1.1875em"><strong>P.S.</strong> Need immediate help getting started? Check out our <a href="" style="color:#853bce" target="_blank" >Discord</a>. Or, just reply to this email, and we'd be happy to help!</p>
                </div>
              </td>
            </tr>
          </tbody></table>
        </td>
      </tr>
      <tr>
        <td style="word-break:break-word;font-family:'Inter',Helvetica,Arial,sans-serif;font-size:16px">
          <table align="center" width="570" cellpadding="0" cellspacing="0" role="presentation" style="width:570px;text-align:center;margin:0 auto;padding:0">
            <tbody><tr>
              <td  align="center" style="word-break:break-word;font-family:'Inter',Helvetica,Arial,sans-serif;font-size:16px;padding:35px">
                <p  style="font-size:13px;line-height:1.625;text-align:center;color:#6b6e76;margin:.4em 0 1.1875em" align="center">© 2022 Meal Dash Corp. All rights reserved.</p>
              </td>
            </tr>
          </tbody></table>
        </td>
      </tr>
    </tbody></table>
  </td>
</tr>
</tbody></table>`;


export default templateEmail;