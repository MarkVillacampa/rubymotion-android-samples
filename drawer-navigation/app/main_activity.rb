class MainActivity < Android::Support::V7::App::AppCompatActivity
  attr_accessor :drawer, :drawer_list, :toggle

  def onCreate(savedInstanceState)
    super
    self.contentView = R::Layout::Drawer

    @drawer = findViewById(R::Id::Drawer_layout)
    @drawer_list = findViewById(R::Id::Left_drawer)

    # Set the adapter for the list view
    drawer_list.adapter = ListAdapter.new
    drawer_list.onItemClickListener = self

    # enable ActionBar app icon to behave as action to toggle nav drawer
    supportActionBar.displayHomeAsUpEnabled = true
    supportActionBar.homeButtonEnabled = true

    # ActionBarDrawerToggle ties together the the proper interactions
    # between the sliding drawer and the action bar app icon
    @toggle = Android::Support::V4::App::ActionBarDrawerToggle.new(self, drawer, R::String::Drawer_open, R::String::Drawer_close)
    @toggle.setDrawerIndicatorEnabled(true)
    drawer.drawerListener = @toggle
  end

  def onItemClick(parent, view, position, id)
    # update the main content by replacing fragments
    fragment = TextFragment.new
    fragment.text = "Fragment #{position}"
    fragmentManager.beginTransaction.replace(R::Id::Content_frame, fragment).commit
    drawer.closeDrawer(drawer_list)
  end

  def onPostCreate(savedInstanceState)
    super
    toggle.syncState
  end

  def onConfigurationChanged(newConfig)
    super
    toggle.onConfigurationChanged(newConfig)
  end

  def onOptionsItemSelected(item)
    !toggle.nil? && toggle.onOptionsItemSelected(item)
  end
end

class ListAdapter < Android::Widget::BaseAdapter
  def getCount
    3
  end

  def getItemId(position)
    position
  end

  def getItem(position)
  end

  def getView(position, convertView, parent)
    text_view = Android::Widget::TextView.new(parent.context)
    text_view.textSize = 18
    text_view.setTypeface(nil, Android::Graphics::Typeface::BOLD)
    text_view.textColor = Android::Graphics::Color::BLACK
    text_view.enabled = false
    text_view.text = "View #{position}"
    text_view
  end
end

class TextFragment < Android::App::Fragment
  attr_accessor :text

  def onCreateView(inflater, container, savedInstanceState)
    text_view = Android::Widget::TextView.new(context)
    text_view.textSize = 18
    text_view.setTypeface(nil, Android::Graphics::Typeface::BOLD)
    text_view.textColor = Android::Graphics::Color::BLACK
    text_view.enabled = false
    text_view.text = text
    text_view
  end
end
