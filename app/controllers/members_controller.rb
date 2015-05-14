class MembersController < ApplicationController
  def index
  end

  def invite
    invitation = Invitation.create invite_params
    InvitationMailer.invitation_email(invitation).deliver_later
  end

  def confirm
  end

  def remove
  end

  private 

  def invite_params
    params.require(:invitation).permit(:email)
  end

end
