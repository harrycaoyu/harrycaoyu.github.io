import smtplib

from email.mime.text import MIMEText

from flask import Flask, request, redirect
app = Flask(__name__)

app.config["DEBUG"]       = True
app.config["LISTEN_HOST"] = "0.0.0.0"
app.config["PORT"]        = 6789
app.config["FROM"]        = "nobody@dmitryblotsky.com"
app.config["TO"]          = ["dmitry.blotsky@gmail.com", "anna@flybrizi.com"]

@app.route("/", methods=["POST"])
def mail():

    if request.method == "POST":

        text    = "\n".join("{0} = {1}".format(k, v) for k, v in request.form.items())
        subject = "Contact Form Submission"

        message            = MIMEText(text)
        message["Subject"] = subject
        message["From"]    = app.config["FROM"]
        message["To"]      = ", ".join(app.config["TO"])

        s = smtplib.SMTP("localhost")
        s.sendmail(app.config["FROM"], app.config["TO"], message.as_string())
        s.quit()

        return redirect("http://flybrizi.com/thanks/"), 302

if __name__ == "__main__":
    app.run(host=app.config["LISTEN_HOST"], port=app.config["PORT"])
