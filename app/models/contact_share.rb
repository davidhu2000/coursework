class ContactShare < ActiveRecord::Base
  validates :user_id, presence: true
  validates :contact_id, presence: true, uniqueness: { scope: :user_id }
  validate :user_cannot_share_owned_contacts

  belongs_to :user
  belongs_to :contact

  def user_cannot_share_owned_contacts
    owned_contact_ids = Contact.where(user_id: self.user_id).map(&:id)

    if owned_contact_ids.include? self.contact_id
      errors[:contact] << "cannot be owned by user"
    end
  end
end
