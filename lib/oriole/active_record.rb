# frozen_string_literal: true

require 'active_record'

module Oriole
  module ActiveRecord
    module QueryMethods
      module OrioleWhereChain
        # Returns a new relation expressing WHERE + OR conditions according to
        # the conditions in the arguments.
        #
        # #or accepts a list of arguments for QueryMethods#where.
        #
        #    User.where.or("name = 'Admin'", { admin: true })
        #    # SELECT * FROM users WHERE (name = 'Admin' OR admin is true)
        def or(*conditions)
          raise ::ArgumentError, 'Cannot create WHERE with OR without at least two conditions' if conditions.count < 2

          initial_scope = @scope.dup
          where_clauses = []
          conditions.each do |opts, *rest|
            opts = sanitize_forbidden_attributes(opts)
            where_clauses << @scope.send(:where_clause_factory).build(opts, rest)
            @scope.references!(::ActiveRecord::PredicateBuilder.references(opts)) if Hash === opts
          end

          @scope.where_clause += where_clauses.shift
          where_clauses.each do |where_clause|
            or_scope = initial_scope.dup
            or_scope.where_clause += where_clause
            @scope = @scope.or(or_scope)
          end
          @scope
        end
      end
      ::ActiveRecord::Relation::WhereChain.include OrioleWhereChain
    end
  end
end
