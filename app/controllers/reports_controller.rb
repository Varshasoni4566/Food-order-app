class ReportsController < ApplicationController

	def download_csv
		debugger
	    report = generate_report(params[:id])
	    send_data report, filename: "report_#{params[:id]}.csv" 
    end

    def download_pdf
    	debugger
	    report_data = generate_report_data
	    send_data generate_pdf(report_data), filename: "report.pdf", type: "application/pdf"
    end


    private

	def generate_report(id)
		debugger
	    users = User.all 
		CSV.generate(headers: true) do |csv|
		    csv << ['ID', 'Name', 'USERNAME', 'Email', 'PASSWORD'] 
		    users.each do |user|
		        csv << [user.id, user.name, user.username,user.email, user.password] 
		    end
	    end
    end

    def generate_pdf(report_data)
    	debugger
	    pdf = Prawn::Document.new
	    pdf.text "Report", align: :center, size: 20
	    pdf.move_down 20
	    pdf.text report_data.inspect 
	    pdf.render
    end

    def generate_report_data
    	debugger
		users = User.all
		report_data = []
		report_data << ["ID", "Name", "Usename", "Email", "Password"] 
		    users.each do |user|
		        report_data << [user.id, user.name, user.username, user.email, user.password]
		    end
		report_data 
    end

end
