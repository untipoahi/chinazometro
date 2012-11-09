class Vote < ActiveRecord::Base
  belongs_to :users
  belongs_to :chinazos
  attr_accessible :value, :users_id, :chinazos_id

  def saveOrUpdate
  	conditionString = 'users_id = ? and chinazos_id = ?', self.users_id, self.chinazos_id
  	@votes = Vote.find(:first, :conditions => conditionString )
  	if @votes
    	@votes.value = self.value
    	return @votes.save
    else
    	return self.save
  	end
  end  
end
