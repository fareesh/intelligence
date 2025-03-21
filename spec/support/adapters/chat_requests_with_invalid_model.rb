require 'spec_helper'

RSpec.shared_examples 'chat requests with invalid model' do | options = {} |

  context 'where the adapter is configured with an invalid model' do
    it 'responds with an appropriate error' do

      response = create_and_make_chat_request(
        send( options[ :adapter ] || :adapter_with_invalid_model ), 
        create_conversation( "respond only with the word 'hello'\n" )
      )

      expect( response.success? ).to be( false )
      expect( response.result ).to be_a( Intelligence::ChatErrorResult )
      expect( response.result.error_type ).not_to be_nil
      expect( response.result.error_type ).to( 
        eq( options[ :error_type ] || 'not_found_error' ),
        response.result.error_description 
      )

    end
  end

end
