using Gst;
using Gtk;

class Platine.MainWindow : GLib.Object {

	private Gtk.Window window;
	private Gtk.Builder builder;
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

		playing = false;
	}

	[CCode (instance_pos = -1)]
	public bool on_quit (Gtk.Widget widget, Gdk.Event event) {
		Gtk.main_quit ();
		return true;
	}

	[CCode (instance_pos = -1)]
	public bool on_play_pause (Gtk.ToggleAction action) {
		if (action.get_active ()) {
				playing = false;
		} else {
			playing = true;
		}
		return true;
	}

	public void populate_album_store () {
		var music = File.new_for_path (MUSIC_LIBRARY_PATH);
		try {
			var children = music.enumerate_children ("standard::*, owner::user",
													 0,
													 null);
		} catch (Error e) {
			error ("Could not load music library: %s", e.message);
		}
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