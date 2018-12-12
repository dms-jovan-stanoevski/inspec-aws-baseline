cis_level = attribute(
    'cis_level',
    default: '2',
    description: 'CIS profile level to audit',
    required: true
    )

title '4 CIS Amazon Web Services Foundations Benchmark, version 1.2.0, Networking section'

control 'cis-amazon-web-services-foundation-benchmark-4.1' do
  impact 1.0
  title "Ensure no security groups allow ingress from 0.0.0.0/0 to port 22"
  desc "It is recommended that no security group allows unrestricted ingress access to port 22."

  tag cis: 'CIS_Amazon_Web_Services_Foundations_Benchmark:1.2'
  tag level: 1

  sg_gids = aws_security_groups.group_ids

  sg_gids.each do |gid|
    describe aws_security_group(id: gid) do
      it { should_not allow_in(port: 22, ipv4_range: '0.0.0.0/0') }
    end
  end
end
