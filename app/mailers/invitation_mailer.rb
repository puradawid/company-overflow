class InvitationMailer < ApplicationMailer
  def invitation_email(invitation)
    @invitation = invitation
    mail(to: invitation.email, subject: "Invitation to CompanyOverflow!")
  end
end
