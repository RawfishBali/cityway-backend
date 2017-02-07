class ChangeDefaultSupportDisabilities < ActiveRecord::Migration
  def change
    change_column_default :culinaries, :support_disabilities, false
    change_column_default :events, :support_disabilities, false
    change_column_default :markets, :support_disabilities, false
    change_column_default :merchants, :support_disabilities, false
    change_column_default :parks, :support_disabilities, false
    change_column_default :places, :support_disabilities, false
    change_column_default :public_transports, :support_disabilities, false
    change_column_default :schools, :support_disabilities, false
    change_column_default :sports, :support_disabilities, false
    change_column_default :utility_places, :support_disabilities, false
    change_column_default :vehicles, :support_disabilities, false
  end
end
