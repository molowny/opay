require 'spec_helper'

module Opay
  describe Providers::Payu do
    context 'md5 signs' do

      before do
        @key1 = Opay.config.key1
        @key2 = Opay.config.key2
      end

      it 'creates md5 sig' do
        pos_id     = '123456'
        session_id = '0cde9e950d99630410661b2dedbbd822'
        ts         = '1234567890'
        sig        = Digest::MD5.hexdigest(pos_id + session_id + ts + @key1)

        # valid sig
        subject.class_eval { create_sig(pos_id, session_id, ts) }.should eq sig

        # invalid sig
        subject.class_eval { create_sig('23456', session_id, ts) }.should_not eq sig
      end

      it 'checks md5 sig' do
        pos_id     = '123456'
        session_id = '0cdeyutyuuytt410661b2dedbbd822'
        ts         = '1234567890'
        sig        = Digest::MD5.hexdigest(pos_id + session_id + ts + @key2)

        # valid received params
        subject.class_eval { verify_sig(sig, pos_id, session_id, ts) }.should be true

        # invalid received params
        subject.class_eval { verify_sig(sig, '23456', session_id, ts) }.should be false
      end

    end
  end
end
