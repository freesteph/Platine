using Gst;
using Gtk;

class Platine.MainWindow : GLib.Object {

	private Gtk.Builder builder;
	private Gtk.Window window;
	private Gtk.ListStore album_store;

	private bool playing;

	// FIXME: xdg_dir + GSettings
	private const string MUSIC_LIBRARY_PATH = "/home/steph/Musique";

	public MainWindow () {
		builder = new Gtk.Builder ();
		try {
			builder.add_from_file ("main.ui");
			builder.connect_signals (this);
		} catch (Error e) {
			error ("Could not load UI file: %s", e.message);
		}

		window = builder.get_object ("window1") as Gtk.Window;
		album_store = builder.get_object ("album_store") as Gtk.ListStore;
		playing = false;
	}

	[CCode (instance_pos = -1)]
	public bool on_quit (Gtk.Widget widget, Gdk.Event event) {
		Gtk.main_quit ();
		return true;
	}

	[CCode (instance_pos = -1)]
	public bool on_play_pause (Gtk.ToggleAction action) {
		playing = !action.get_active ();
		return true;
	}

	public void add_to_store (File f) {
		Gtk.TreeIter iter;
		Gdk.Pixbuf? cover = null;
		try {
			cover = new Gdk.Pixbuf.from_file_at_size (f.get_uri (), -1, 64);
		} catch (Error e) {
			error ("Can't create pixmap: %s", e.message);
		}
		assert (cover != null);
		album_store.append (out iter);
		album_store.set (iter,
						 0, "Radiohead",
						 1, "Kid A",
						 2, 2000,
						 3, cover,
						 -1);
	}

	public void populate_album_store () {
			var music = File.new_for_path (MUSIC_LIBRARY_PATH + "/cover.jpg");
			add_to_store (music);
	}
		
	public void run () {
		var settings = Gtk.Settings.get_default ();
		settings.set ("gtk-application-prefer-dark-theme", true, null);
		window.show_all ();
		populate_album_store ();
		Gtk.main ();
	}
}

public static void main (string []args) {

	Gtk.init (ref args);
	Gst.init (ref args);

	var platine = new Platine.MainWindow ();
	platine.run ();
}