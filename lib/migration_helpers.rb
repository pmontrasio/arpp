#(C) 2008 NET GAMES TECH S.A.S. di Ramon Soletti, Paolo Montrasio e C.
# All rights reserved

module MigrationHelpers
  def foreign_key(from_table, from_column, to_table)
    constraint_name = "fk_#{from_table}_#{from_column}" 

    execute %{alter table #{from_table}
              add constraint #{constraint_name}
              foreign key (#{from_column})
              references #{to_table}(id)}
  end

  def remove_foreign_key(from_table, from_column)
    constraint_name = "fk_#{from_table}_#{from_column}" 

    execute %{alter table #{from_table}
              drop constraint #{constraint_name}}
  end
end
