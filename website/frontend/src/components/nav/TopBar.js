import React, { useEffect, useState } from 'react';
import { useDispatch } from 'react-redux';
import { showGetInvolvedModal } from 'reduxStore/GetInvolved/operations';
import AirQo from 'icons/nav/AirQo';
import MenuIcon from 'assets/svg/Menu.svg';
import CloseIcon from 'assets/svg/Close.svg';
import { Link } from 'react-router-dom';
import NavTab from './NavTab';

const TopBar = () => {
  const dispatch = useDispatch();
  const showModal = () => dispatch(showGetInvolvedModal(true));

  const toggleMenu = () => {
    setOpenItem(null);
    document.getElementById('menu').classList.toggle('toggle_menu_btn');
    document.getElementById('close-menu').classList.toggle('toggle_close_menu_btn');
    document.getElementById('nav-center').classList.toggle('toggle_nav_center');
    // document.getElementById('nav-right').classList.toggle('toggle_nav_right');
  };

  const toggleCloseMenu = () => {
    setOpenItem(null);
    document.getElementById('close-menu').classList.remove('toggle_close_menu_btn');
    document.getElementById('menu').classList.remove('toggle_menu_btn');
    document.getElementById('nav-center').classList.remove('toggle_nav_center');
    // document.getElementById('nav-right').classList.remove('toggle_nav_right');
  };

  // tracking the current open item
  const [openItem, setOpenItem] = useState(null);

  // for handling window resize
  const [width, setWidth] = useState(window.innerWidth);

  useEffect(() => {
    const handleResize = () => setWidth(window.innerWidth);
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);

  // Handling click event
  const handleClick = (item) => {
    if (width < 1024) {
      setOpenItem(openItem === item ? null : item);
    } else {
      return;
    }
  };

  return (
    <div className="TopBar">
      <div className="wrapper">
        <div className="logo">
          <Link to="/">
            <AirQo />
          </Link>
        </div>
        <div className="nav-center" id="nav-center">
          <div className="nav-wrapper">
            <div className="nav-dropdown-item">
              <NavTab text="Products" onClick={() => handleClick('Products')} />
              <div className="dropdown" id={openItem === 'Products' ? 'solutions-dropdown' : ''}>
                <h3 className="title">Products</h3>
                <div className="dropdown-list">
                  <div className="dropdown-list-item">
                    <Link to="/products/monitor" style={{ textDecoration: 'none' }}>
                      <h3>Binos Monitor</h3>
                      <h4>Built in Africa for African cities</h4>
                    </Link>
                  </div>
                  <div className="dropdown-list-item">
                    <Link to="/products/analytics" style={{ textDecoration: 'none' }}>
                      <h3>Analytics Dashboard</h3>
                      <h4>Air quality analytics for African Cities</h4>
                    </Link>
                  </div>
                  <div className="dropdown-list-item">
                    <Link to="/products/mobile-app" style={{ textDecoration: 'none' }}>
                      <h3>Mobile App</h3>
                      <h4>Discover the quality of air around you</h4>
                    </Link>
                  </div>
                  <div className="dropdown-list-item">
                    <Link to="/products/api" style={{ textDecoration: 'none' }}>
                      <h3>Air Quality API</h3>
                      <h4>Access raw and calibrated data</h4>
                    </Link>
                  </div>
                  <div className="dropdown-list-item">
                    <Link to="/products/calibrate" style={{ textDecoration: 'none' }}>
                      <h3>AirQalibrate</h3>
                      <h4>Calibrate your low-cost sensor data</h4>
                    </Link>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div className="nav-dropdown-item">
            <NavTab text="Solutions" onClick={() => handleClick('Solutions')} />
            <div className="dropdown" id={openItem === 'Solutions' ? 'solutions-dropdown' : ''}>
              <h3 className="title">Solutions</h3>
              <div className="dropdown-list">
                <div className="dropdown-list-item">
                  <Link to="/solutions/african-cities" style={{ textDecoration: 'none' }}>
                    <h3>For African Cities</h3>
                    <h4>Advancing air quality management in African Cities</h4>
                  </Link>
                </div>
                <div className="dropdown-list-item">
                  <Link to="/solutions/communities" style={{ textDecoration: 'none' }}>
                    <h3>For Communities</h3>
                    <h4>Empowering communities with air quality information</h4>
                  </Link>
                </div>
                <div className="dropdown-list-item">
                  <Link to="/solutions/research" style={{ textDecoration: 'none' }}>
                    <h3>For Research</h3>
                    <h4>Free access to air quality analytics</h4>
                  </Link>
                </div>
              </div>
            </div>
          </div>
          <div className="nav-dropdown-item single-links">
            <NavTab text="About" onClick={() => handleClick('About')} />
            <div className="dropdown" id={openItem === 'About' ? 'solutions-dropdown' : ''}>
              <h3 className="title">About AirQo</h3>
              <div className="dropdown-list">
                <div className="dropdown-list-item">
                  <Link to="/about-us">
                    <h3>About Us</h3>
                  </Link>
                </div>
                <div className="dropdown-list-item">
                  <Link to="/clean-air">
                    <h3>CLEAN-Air Network</h3>
                  </Link>
                </div>
                <div className="dropdown-list-item">
                  <Link to="/events">
                    <h3>Events</h3>
                  </Link>
                </div>
                <div className="dropdown-list-item">
                  <Link to="/resources">
                    <h3>Resources</h3>
                  </Link>
                </div>
                <div className="dropdown-list-item">
                  <Link to="/press">
                    <h3>Press</h3>
                  </Link>
                </div>
                <div className="dropdown-list-item">
                  <Link to="/careers">
                    <h3>Careers</h3>
                  </Link>
                </div>
                <div className="dropdown-list-item">
                  <Link to="/contact">
                    <h3>Contact Us</h3>
                  </Link>
                </div>
              </div>
            </div>
          </div>
          {/* <NavTab text="About" path="/about-us" hideArrow /> */}
          <NavTab text="Get involved" hideArrow colored onClick={showModal} />
          <NavTab text="Explore data" path="/explore-data" hideArrow filled />
        </div>
      </div>
      <MenuIcon className="menu-btn" id="menu" onClick={toggleMenu} />
      <CloseIcon className="close-menu-btn" id="close-menu" onClick={toggleCloseMenu} />
    </div>
  );
};

export default TopBar;
