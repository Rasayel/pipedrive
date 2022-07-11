# frozen_string_literal: true

module Pipedrive
  module Operations
    module Search
      extend ActiveSupport::Concern
      include ::Enumerable
      include ::Pipedrive::Utils
      
      def each(params = {}, &block)
        return to_enum(:each, params) unless block_given?
        
        follow_pagination(:chunk, [], params, &block)
      end
      
      def all(params = {})
        each(params).to_a
      end
      
      def chunk(params = {})
        res = make_api_call(:get, params)
        return [] unless res.success?
        
        res
      end
      
      def search(term, fields, exact_match = true)
        make_api_call(:get, "search", term: term, fields: fields, exact_match: exact_match)
      end
    end
  end
end
