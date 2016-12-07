# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ActiveRecord::Base
  STATUS = ['PENDING', 'APPROVED', 'DENIED'].freeze

  validates :cat_id, presence: true
  validates :status, presence: true, inclusion: STATUS
  validates :start_date, :end_date, presence: true
  validate :end_date_is_after_start_date, if: :start_date && :end_date
  validate :overlapping_requests, if: :start_date && :end_date

  belongs_to :cat

  def end_date_is_after_start_date
    if self.end_date < self.start_date
      errors[:start_date] << "cannot be after end date."
    end
  end

  def overlapping_requests
    overlapping_approved_requests
  end

  def overlapping_approved_requests
    requests = CatRentalRequest.where(cat_id: self.cat_id).where(status: 'APPROVED')

    overlaps = requests.any? do |request|
      self.status == 'APPROVED' &&
      (self.start_date..self.end_date).overlaps?(request.start_date..request.end_date)
    end

    errors[:date] << "cannot overlap with another request." if overlaps
  end

  def overlapping_pending_requests
    requests = CatRentalRequest.where(cat_id: self.cat_id).where(status: 'PENDING')

    requests.select do |request|
      self.id != request.id &&
      (self.start_date..self.end_date).overlaps?(request.start_date..request.end_date)
    end
  end

  def approve!
    self.transaction do
      self.status = 'APPROVED'
      self.save!
      overlapping_pending_requests.each do |req|
        req.deny!
      end
    end
  end

  def deny!
    self.status = 'DENIED'
    self.save!
  end
end
