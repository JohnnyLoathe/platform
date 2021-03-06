module Admin
  module Withdraws
    class HvsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Hv'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24 * 3)
        @one_hvs = @hvs.with_aasm_state(:almost_done).order("id DESC")
        @all_hvs = @hvs.without_aasm_state(:almost_done).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        @hv.process!
        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @hv.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
