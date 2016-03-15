class Bug < ActiveRecord::Base
  enum status: {unassigned: 0, assigned: 1, resolved: 2, closed: 3} do
    event :assign do
      transition :unassigned => :assigned
    end

    event :resolve do
      before do
        self.resolved_at = Time.zone.now
      end

      transition [:unassigned, :assigned] => :resolved
    end

    event :close do
      transition all => :closed
    end
  end
end
