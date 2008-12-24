module MbtermDb
  require 'specification'

  class ActionController::Base
    def set_mbterm_info
      user_agent = request.env['HTTP_USER_AGENT']
      begin
        if user_agent =~ /^DoCoMo\/2.0 (.+)\(/
          # DoCoMo (FOMA)
          request.env['MB_CARRIER']       = MbtermDb::DOCOMO[$1][:carrier]
          request.env['MB_MODEL']         = MbtermDb::DOCOMO[$1][:model]
          request.env['MB_HTML_VERSION']  = MbtermDb::DOCOMO[$1][:html_version]
          request.env['MB_XHTML_VERSION'] = MbtermDb::DOCOMO[$1][:xhtml_version]
          request.env['MB_COLUMN']        = MbtermDb::DOCOMO[$1][:column]
          request.env['MB_ROW']           = MbtermDb::DOCOMO[$1][:row]
          request.env['MB_B_WIDTH']       = MbtermDb::DOCOMO[$1][:browser_width]
          request.env['MB_B_HEIGHT']      = MbtermDb::DOCOMO[$1][:browser_height]
          request.env['MB_WIDTH']         = MbtermDb::DOCOMO[$1][:physical_width]
          request.env['MB_HEIGHT']        = MbtermDb::DOCOMO[$1][:physical_height]
        elsif user_agent =~ /^DoCoMo\/1.0\/(.+?)\//
          # DoCoMo (MOVA)
          request.env['MB_CARRIER']       = MbtermDb::DOCOMO[$1][:carrier]
          request.env['MB_MODEL']         = MbtermDb::DOCOMO[$1][:model]
          request.env['MB_HTML_VERSION']  = MbtermDb::DOCOMO[$1][:html_version]
          request.env['MB_XHTML_VERSION'] = MbtermDb::DOCOMO[$1][:xhtml_version]
          request.env['MB_COLUMN']        = MbtermDb::DOCOMO[$1][:column]
          request.env['MB_ROW']           = MbtermDb::DOCOMO[$1][:row]
          request.env['MB_B_WIDTH']       = MbtermDb::DOCOMO[$1][:browser_width]
          request.env['MB_B_HEIGHT']      = MbtermDb::DOCOMO[$1][:browser_height]
          request.env['MB_WIDTH']         = MbtermDb::DOCOMO[$1][:physical_width]
          request.env['MB_HEIGHT']        = MbtermDb::DOCOMO[$1][:physical_height]
        elsif user_agent =~ /^(?:KDDI|UP.Browser\/.+?)-(.+?) /
          # Au
          request.env['MB_CARRIER']       = MbtermDb::AU[$1][:carrier]
          request.env['MB_MODEL']         = MbtermDb::AU[$1][:model]
          request.env['MB_B_VERSION']     = MbtermDb::AU[$1][:browser_version]
          request.env['MB_COLUMN']        = MbtermDb::AU[$1][:column]
          request.env['MB_ROW']           = MbtermDb::AU[$1][:row]
          request.env['MB_B_WIDTH']       = MbtermDb::AU[$1][:browser_width]
          request.env['MB_B_HEIGHT']      = MbtermDb::AU[$1][:browser_height]
          request.env['MB_WIDTH']         = MbtermDb::AU[$1][:physical_width]
          request.env['MB_HEIGHT']        = MbtermDb::AU[$1][:physical_height]
        elsif user_agent =~ /^(SoftBank|Vodafone|J-PHONE)\/.+?\/(.+?)(\/|$)/
          # SoftBank
          request.env['MB_CARRIER']       = MbtermDb::SOFTBANK[$2][:carrier]
          request.env['MB_MODEL']         = MbtermDb::SOFTBANK[$2][:model]
          request.env['MB_SERIES']        = MbtermDb::SOFTBANK[$2][:series]
          request.env['MB_COLUMN']        = MbtermDb::SOFTBANK[$2][:column]
          request.env['MB_ROW']           = MbtermDb::SOFTBANK[$2][:row]
          request.env['MB_B_WIDTH']       = MbtermDb::SOFTBANK[$2][:browser_width]
          request.env['MB_B_HEIGHT']      = MbtermDb::SOFTBANK[$2][:browser_height]
          request.env['MB_WIDTH']         = MbtermDb::SOFTBANK[$2][:physical_width]
          request.env['MB_HEIGHT']        = MbtermDb::SOFTBANK[$2][:physical_height]
        end
      rescue 
        request.env['MB_CARRIER'] = "UNKNOWN"
        request.env['MODEL'] = "UNKNOWN"
      end
    end
  end
end
