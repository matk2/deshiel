module User::Pupil
  extend ActiveSupport::Concern

  included do
    has_many :entries_as_pupil, class_name: 'Entry', foreign_key: :pupil_id
    has_many :master_relations
    has_many :masters, through: :master_relations
  end

  def master?(master)
    current_masters.include?(master)
  end

  def current_masters
    masters.where("due_at >= ?", Time.now)
  end

  def entries_by_master(master)
    entries_as_pupil.where(master_id: master.id)
  end

  def pupil_due(master_id)
    master_relations.find{ |relation| relation.due_at >= Time.now && relation.master_id == master_id }.due_at.strftime("%Y/%m/%d %H:%M:%S")
  end

  def master_relations_to_rate
    master_relations.where("due_at < ? AND rating IS NULL", Time.now)
  end

  def applied_pupil?(master_user)
    master_relations.where(due_at: nil).map{ |r| r.master_id }.include?(master_user.id)
  end

  def master_candidates
    masters.where("due_at IS NULL")
  end
end
