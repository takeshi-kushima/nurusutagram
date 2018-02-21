class ContactMailer < ApplicationMailer
  def contact_mail(contact)
   @blog = blog
   mail to: @blog.user.email, subject: "投稿が完了いたしました"
  end
end
