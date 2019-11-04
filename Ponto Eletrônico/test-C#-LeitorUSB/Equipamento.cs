using System;
using System.Collections.Generic;
using System.Drawing;
using System.Runtime.Serialization;

namespace TestFutronic
{
    #region Estruturas a serem usadas para iDAccess / iDClass

    // Para objetos que precisam informar a sessão
    [DataContract]
    public abstract class SessionRequest
    {
        [DataMember(Name = "session")]
        public string Session { get; set; }
    }

    // {"login":"admin","password":"admin"}
    [DataContract(Name = "login")]
    public class ConnectRequest
    {
        [DataMember(Name = "login")]
        public string Login { get; set; }

        [DataMember(Name = "password")]
        public string Password { get; set; }
    }

    // "{\"error\":\"Expectation failed\",\"code\":417}"
    [DataContract]
    public class StatusResult // ErrorResult do sdk iDAccess
    {
        [DataMember(Name = "error")]
        public string Status;

        [DataMember(Name = "code")]
        public int Codigo;
    }

    // {"session":"SoypLPHIBTjsnxICNBNmdDhs"}
    [DataContract]
    public class ConnectResult : StatusResult
    {
        [DataMember(Name = "session", EmitDefaultValue = false)]
        public string Session { get; set; }
    }

    // {"login":"admin","password":"admin"}
    [DataContract(Name = "logout")]
    public class LogoutRequest
    {
        [DataMember(Name = "session")]
        public string Session { get; set; }
    }

    // {"session":"vOfVLpmiqg6gWHhYUHe6dJTk","new_templates":[],"remove":false,"templates":["SUNSUzIxAAAE8gEBAAAAAMUAxQBAAeABAAAAhMQqlgB1APEPfACXAFYP2wCXABgPzACzAB8PMAGzAB0PrgDAAAAP2QDDAJUPIAHDACQPtgDWAF0PeADdAFAPwwDpACYOpgDwAOQPngDyAE4PuQD4AE8NxwAAATQNnQASAU0PlAAUAdEP3gAYAToP6AAYATMP3gAyAUMPYQA3AdIP2ABGAUsNEgFVAawPvwBaAdMN2ABdAT4MewBiAdAPxgBxAfMOCgFzAaIP9wB1AZkOqgB3AdkPkwB+AdUP0QB+AYAOvgCDAfoOLgGGAZgP0gCMAQwPdwCTAeAPIgGaAZEPkQCcAeEPEAGiAYgPbgC0Ae8PqwC1AfYPbQDFAfMP6p+j28fzBmdLW28Lvviqh8sbhY02CNIgxfrfi\/MHsaZy4IZvkXlaOm6XPQrfk\/cPTTrVXnp4RgdDbR9TtdkBypX2FJqtlZbAKG49A3YASRwJKcFt4eQFEm78rH72AP5pqIZ+hYbuSAuJ++oIzPud8+oCifn9Cw0T2wWXA5uHAQl1Dpp4IgwyFwMW4eKxlpKIBfbJbqFP1v338F8BsXTh+UEiWQmq+PIO5fleGoZeveIdBqHrof7u9BL1PXSljHWJfX1ZCZnyQQp++koSMYwFFiYYrQPu8YYNYQnF+pvwLQNiDMLt6fna8rfo1fxeEXoTKhVb\/WvuUQRXFW8WStQAOFMAIDwBAsAqtQYAgTVpcMEMAKc5dMCUwlh7CQCFPGvCwHBlDgC7QYDCkcDAwHJqBgD5Woxiwg4Ar0x6mcFke1kOAJpy8P\/9OEDBRhkBH3+acnfAjYXCZv9TjRkBG4SXZ8CFw8PBw1llXcFbEgB\/lNz\/KjA2RE4MAN+XFz44wWQLAHeaWmv+wVvCDAB8nVD+W1ZmEwB+pdzA\/yr9OP\/+wMDANxEAz7EW\/v4+ZGTB\/3AIAMezgMXCwcF2BACxv\/QbBAEjxiRKEADcxyT\/N8DAwMDAcHALAHfiU1tkWB4BO9ekwcH\/wGrCwsCRxMH\/wcHBVkzBeAUAv+dxxJkMAMfoHv4ywE6FDQDE7SfAKv\/+\/MP8eBMAqO7gwPb7K\/7D\/v\/AwsJqwBIAu+5ciETB\/sBAQsEOAL\/yQ\/\/9wsBK\/mv9CwCG9VDAwMDA\/W3\/DwCb9lPCwEXAwP8oeBIAuPxQwMJGW8D+\/8D+dQoQxQM3wvz8Uj8HEMoDLf\/8\/yghAT34qcFKeMDBmZuHfsBlVcNuChDAEEn\/wjL\/awcQmRRQwVXADhCeFklC\/8D9\/0eDERDFFkAxXf\/\/wCmDChDpGjH\/cXbDBRDfHDpcHxBjNNBlc\/82\/f\/7\/\/wx\/1LAwFhyIhE+KLOEVMDAwsCLw8LFwcHCwHbAXcBzwAYQ3jlAwcDIwCURPTmt\/35UwGmIw8PEfHXBP8BbSsIIENhSVj9aHxEPUqtEZGvEw8TFxHxobTD\/aQMQ7l4gwCQQQXfkb3RkwEcs\/fv9\/v\/A\/8DAwMDAwXFvAxEOdxrBBRD7eRPAYQoQp3tewTVnwgkQvn\/k+Sv\/VgcQuoZpwjjACBDChv0wVQUQ2Y0QahERDKSAM8DFncBAwnYKEK6y9zPAdv4PESWyjMHD\/jefTMAQESHEiX43wv+I\/\/7ADhESzYNr\/cF\/h\/8LERbXev5XcXhEQgEBAAAAFgAAAAACBQAAAAAAAEVC","SUNSUzIxAAAE+AEBAAAAAMUAxQBAAeABAAAAhMozhgBOAPYPxABzABYPZwB1AFsOXACGANsOtQCOACAPHAGWACgPmACXAAQPwQCeAJcPCwGiACoPXQC4AFQPZADKANIPhADNAE4PbADOAFMPrwDXADkOpwDjAEoOrwDnAEQOfQDqAM4PhgDrAE8P0gDtADQPxgDwAD0PHQH9ACsPxAAIAUENQAAPAdUPpAAdAdMPxAAeAUIMrwAoAd8M9gAuAa4P1gAwAbINuAA3Af8MWgA5AdQPpwBEAfYNjABJAdwO7ABKAaQP1wBNAZMPtQBPAX0NcwBQAdkPtQBdAQ8NCgFgAaAPVwBmAeAPbwBuAeMP\/gBzAZkPiAB8AfoP6wB8AY4PTwCLAecP\/QCTAYsPtACxAX8PhAC5AQEOwgC5AQYPBAG6AYcPZgDCAfYPvgDJAX4P553nH6Pjwviug9MWfYEDZT9bfYHnibPbhYnWHDYMwQHXk+sXcuSGb2PykXlyl66DPQXbl+8XXYVVA0ILwIJhgbKEsf5+gHIAwIItBtUDofCJ9Gr9SAoREEoN0P79DE0KuIJ+gF58tILyACoFxPui9NbxOAuJ\/tX6s3\/f+797gQIFBhYM1wCXC4MHzfSykNbUAQKtZmGSQQzN4JGeIgxS\/DYfcXINI0a0LSDpCcmGzv3y91cApXlx+QUfGQed665iWRGu+IL16fGt424ZRXChicmCnf\/u+EYFMZQdG2J+OQp6\/UYXrf6GCer6LQax62YMVQ3B+ioQHRs3IEsh4fUZB9bzYgp+B5Pvnf+69C4GGXgxA3+A9gx7hI+HEYjFiP8Hsv57g6v7gvQ\/E1\/\/zXi1A49\/mKgEgyGDByAwAQJZJAELAKA0epNWwmQHAIQ1cIeEBgDSPAn9wD4RAIpM9P8p\/0z\/wf5EwRAAx3MT\/\/5G\/\/9w\/8JGFwBghd7AwCouR\/7A\/8A2ZAcAWYlaWGgaATKKoMDAe8L\/g\/\/Cw8NpWcBpDgCwjYDEw8CQUcDAwhQAuI0W\/i9C\/sJS\/8HBwWEDAJ2W\/fsFAR2aJEUSAMShIkBKa8DAwXvBCAENpC3BwMBkHQAqu9M+aEL9\/jtAVERU\/wkAXL1Xwf\/AwHQdAGXF08BA\/iP7QP7\/wMDAwcD\/wP\/Cwf+ACQCHydr++vz7\/cD\/CQCoyRf8I8AeEQCgy2CSOMA9wMBKDgCA0FDC\/v\/AazBvDgCm0Ub9wMJGVcA\/CgBr0lZkwFDAEACh01Z+RET\/Zf8KALLbLf3+I8BgHwAp38\/9wML9wcE+Qf79Nyj\/R8DAwGAKAKfmSf9HRf8RAK3rRjcyR\/9awMIFALPrPf0xIQAo7tf\/XcBk\/zssXi\/\/\/sBiYsANANbwNMBpwv9diQwAhfFQYE\/AwVAKANHxN8B8wcBqBQDF8jpcBhEeAStk\/yMQKQjGKMFUwcA9\/v7+\/f04\/\/5K\/3hbwAkQwiJX\/Hv\/agUQxyIwxMDAHhD0K61F\/sLAwcDAxMPDxp1zUcL9RP8EEKssYGQnECUz2n5Ewf\/CPUH+\/f79\/\/3\/Pf\/AwMHARWTADBC+NQ\/8clL\/UxgQWzfXcEvCwP38+fv9\/sD\/wP\/BwYkEEKpD8BglEC5H2mJrWUcs\/fsqwT\/\/wWLAwmbBCRCJTGDAwMD\/wF0DEO9NIMEJEJ9O8Pz8Vz5EQgEBAAAAFgAAAAACBQAAAAAAAEVC","SUNSUzIxAAAE\/gEBAAAAAMUAxQBAAeABAAAAhNAzeABWAPYPAQFwAJsPVQB6AFgPswB6ABUPTACRANgPoQCXABgPDgGfACcPsACkAJAPhgClAP0P\/ACnACkPJwGyACEPUADFAFAPmwDXACAOVgDaANAPYQDbAE8PfQDdAE4PqADnADkOqADzAEIOygDzADEPvgD3ADcPcwD5AM4PfgD6AEsPNwEAAacPEgEDASgPwAARAT4OPQAhAc4PogAqAc4PwwAxAUAMrgA1Ad0M7wA3Aa0P1AA5AbANuAA9AfoMXQBIAc0P8ABQAaIPqwBSAfwNkABZAdcP2ABZAZIPtgBeAX0OqgBfAf0OnwBgAe4OdgBjAdUPCgFpAZ8PtgBsAQwOMwFuAZ8PWgB3AdsP\/wB9AZgP8QCEAY0PdACFAd4PjwCQAfYPBAGfAYgPJwGoAZEP66Gj4+cjH3QrdhN\/eYILZUdfwv2yh88beYLnibffhYnWHEIFyQF2CBOMjXlyl7Z\/cuSGb7feSQViCx+S+vzq+wuLZYJVA0cFhena1JLgtINlgraGtIPZAzUDtQNxB4KAiPvtGWEHAAtFDu4kxP+e9NLxPAvR9on7tIeCgF6BuH\/1\/9r\/VoGTi0P\/VoGzf+P7AQsSDIIA2wGbA4MD0fDR176RoUhVkbllwOdBEJ2dEQ5R\/y4eZXHNB027IB9lvN0C1vn39FsBnfZRE\/4FyAOlgOERvei13x0H4fOq5GoVgINFcKWAABOAg0gDkPMlGHH1nQPu+RL9NQqC\/UIVNZAVEQkjagJXCisTuvyOCWsQVQy9+iYR4fQeBNLxses6BGYJGRtbCTchovy28Qb5egmT+7v3thQHuAh6ASAvAQJfItYJANlEEDJR\/wMA+E4gwRMAfFT3Qf5M\/8BGVlsRAQJrnMDBb8DBwsDEwcHAfhMA\/XCaam99wMT\/asHBBgEFcyBYwBMAWHbiQf04Nv7ARmgFAFB8XsJmEgC3fBD+Pv5Ywf90wD0ZAFCQ3sE1J\/9A\/0T\/Q2r\/BQBJlVrAdxUApZUPKD5YwVXBaVoOAJ2XfaTCwcE6wGoHARCiJ8DAawMAiqP0+xMAtKgg\/\/\/AQ8DAVsDCWMIIAP6qKcDAwMBwBwBPyFDAUsAeAFfX0MBA\/yQjOP5rXcDAwMF0EACT2FqSNkbARMIIAKPYHCTBISAAK9zP\/8D+aFX+\/f7\/Mv3\/wMD\/wP\/\/wf\/BwDAIAGDgUMDAwMD+wg4AmuBA\/MJXRf\/A\/v4NAJXiUMHBwTZEQQsAoOVA\/mU+VgoArOotJ\/1RwSEAKu\/QTFn+\/8D+Lv08Rv9DwGpgFgDI76vBfbLAw23AWMH8SgYAzvYwwMBsDwCl90A2\/sDAwf1MWQUAq\/c3\/fzBCwDJ9zHAZnDB\/wYAvvo3XMELAH3+SVU+RCMQLAPJ\/v7C\/1r+wP8u\/f3+wP81\/2TB\/3vARgcRFAYpwMH\/ViYQMy7MwjLBWjX\/\/sD8\/f3\/\/cH+\/\/\/+wsD\/wv7\/w\/\/\/wcLABxDHMyJvPxwQ8DOtUlr\/wsDCxMSphEJYMwQQrDhcXAkQ8jsnwWR+DBC8Pwz8\/3vAwcBNCBC0QGLC\/1L\/IxA+RNZwwGXD+8H\/\/fz9\/P3+wP7AwP\/B\/8DAwcDBwv9zGBBeRdDC\/\/9exP79+vn9\/v7A\/sDAwsDBwQQQr0\/wFgBEQgEBAAAAFgAAAAACBQAAAAAAAEVC"],"user_pis":0}
    [DataContract(Name = "template_merge")]
    public class TemplateMergeRequest : SessionRequest
    {
        [DataMember(Name = "templates")]
        public string[] Templates = new string[] { };

        [DataMember(Name = "remove")]
        public bool Remove { get; set; }

        [DataMember(Name = "user_pis")]
        public UInt64 PIS { get; set; }

        [DataMember(Name = "new_templates")]
        public string[] NewTemplates = new string[] { };
    }

    // {"template":"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"}
    [DataContract()]
    public class TemplateMergeResult : StatusResult
    {
        [DataMember(Name = "template")]
        public string Template;
    }

    // string cURL = "https://192.168.0.146/template_extract.fcgi?session=" + rep.iDClassSession +"&width=" + digital.Width/3 + "&height=" + digital.Height;
    // {"quality":3,"template":"SUNSUzIxAAAAagEBAAAAAMUAxQBSAFkAAAAAgDwBJAAsAPcOCAAIAAgAACAFAQApASsFACkFdMaZBABGEonFwQUASRqMqQUASyCJowQAPS+DxcYAREIBAQAAABYAAAAAAgUAAAAAAABFQg=="}
    [DataContract]
    public class TemplateResult : StatusResult
    {
        [DataMember(Name = "quality")]
        public int Qualidate;

        [DataMember(Name = "template")]
        public string Template;
    }

    #endregion

    /// <summary>
    /// Essa classe funciona tanto para REP iDClass como para controlador de Acesso iDAccess
    /// </summary>
    public class Equipamento
    {
        private string URL, Session;
        public string Status { get; private set; }

        public bool Login(string url, string user = "admin", string pass = "admin")
        {
            try
            {
                if (!url.EndsWith("/"))
                    url += "/";

                ConnectResult st = RestJSON.Send<ConnectResult>(URL = url.ToLower(), new ConnectRequest()
                {
                    Login = user,
                    Password = pass
                });

                if (st.Session == null)
                {
                    Status = "Erro ao Conetar: " + st.Status ?? "?";
                    return false;
                }

                Session = st.Session;
                Status = "Equipamento Conectado";
                return true;
            }
            catch (Exception ex)
            {
                Status = ex.Message;
                return false;
            }
        }

        public string ExtractTemplate(Bitmap digital, out int quality)
        {
            try
            {
                quality = -1;
                if (Session == null || digital == null)
                    return null;
                else
                {
                    TemplateResult tr = RestJSON.Send<TemplateResult>(URL + "template_extract.fcgi?session=" + Session + "&width=" + digital.Width + "&height=" + digital.Height, RestJSON.GetBytes(digital));
                    quality = tr.Qualidate;
                    return tr.Template;
                }
            }
            catch (Exception ex)
            {
                quality = -2;
                Status = ex.Message;
                return null;
            }
        }

        public string MergeTemplate(string[] templates, out string info)
        {
            info = "?";
            try
            {
                if (Session == null || templates == null || templates.Length != 3)
                    return null;
                else
                {
                    if (URL.StartsWith("https://"))
                    {
                        // iDClass
                        TemplateMergeResult tmr = RestJSON.Send<TemplateMergeResult>(URL, new TemplateMergeRequest()
                        {
                            Session = this.Session,
                            Templates = new string[] { templates[0], templates[1], templates[2] }
                        });
                        info = tmr.Status ?? "OK";
                        return tmr.Template;
                    }
                    else
                    {
                        List<byte> btRequest = new List<byte>();
                        byte[] bt1 = Convert.FromBase64String(templates[0]);
                        btRequest.AddRange(bt1);
                        byte[] bt2 = Convert.FromBase64String(templates[1]);
                        btRequest.AddRange(bt2);
                        byte[] bt3 = Convert.FromBase64String(templates[2]);
                        btRequest.AddRange(bt3);
                        StatusResult st = RestJSON.Send<StatusResult>(URL + "template_match.fcgi?session=" + Session + "&size0=" + bt1.Length + "&size1=" + bt2.Length + "&size2=" + bt3.Length, btRequest.ToArray());
                        info = st.Status ?? "OK";
                        return null;
                    }
                }
            }
            catch (Exception ex)
            {
                Status = info = ex.Message;
                return null;
            }
        }
    }
}