class EventPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    (user.role == "admin") || record.lloguer == false
  end

  def create?
    user.role == "admin" || user.role == "premium"
  end

  def update?
    user.role == "admin" || user.role == "premium"
  end

  def destroy?
    user.role == "admin" || user.role == "premium"
  end

  def accept_or_decline?
    user.role == "admin"
  end

  def obert_o_tancat?
    user.role == "admin"
  end

  class Scope < Scope
    def resolve
      if user.role == 'admin'
        scope.all #.sort(:lloguer)
      else
        scope.all
      end
    end
  end
end
# scope :with_cd_player, joins(:car => :radio).where('cars.radio_id is not null').where("radios.category = 'cd_player'")
 # :lloguer, => {
 #        .joins(:client)
 #        .where(client: {lloguer: false})}
