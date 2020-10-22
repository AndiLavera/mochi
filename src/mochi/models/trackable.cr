module Mochi::Models
  # Track information about your user sign in.
  #
  # Columns:
  #
  # - `sign_in_count : Integer` - Total amount of times a user has successfully signed in. Increased every time a sign in is made (by form, openid, oauth)
  # - `current_sign_in_ip : String? - The most recent IP address used to sign in
  # - `last_sign_in_ip : String?` - The second most recent IP address used to sign in
  # - `current_sign_in_at : Timestamp?` - The time a user last signed in at
  # - `last_sign_in_at : Timestamp?` - The second most recent time a user signed in
  #
  # Configuration:
  #
  # TODO
  #
  # Examples:
  #
  # TODO
  module Trackable
    def update_tracked_fields!(request)
      # We have to check if the user is already persisted before running
      # TODO: self.save(skip_validation: true)
      # Need to open PR with Granite
      return if new_record?

      update_tracked_fields(request)
      self.save
    end

    def update_tracked_fields(request)
      old_current, new_current = self.current_sign_in_at, Time.utc
      self.last_sign_in_at = old_current || new_current
      self.current_sign_in_at = new_current

      # TODO: Find new method of getting ip address from amber framework
      # old_current, new_current = self.current_sign_in_ip, extract_ip_from(request)
      # self.last_sign_in_ip = old_current || new_current
      # self.current_sign_in_ip = new_current

      self.sign_in_count ||= 0
      self.sign_in_count += 1
    end

    private def extract_ip_from(request)
      request.remote_address
    end
  end
end
