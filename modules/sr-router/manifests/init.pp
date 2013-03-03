class sr-router {
  include sr-router::bind
  include sr-router::dhcp
  include sr-router::groups
  include sr-router::sysctl
  include sr-router::sudo
  include sr-router::scripts
}
