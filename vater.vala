class Vater : GLib.Object {

	private static void setFont(Vte.Terminal terminal) {
		var font = GLib.Environment.get_variable ("VATER_FONT") ?? "BiWidth";
		terminal.set_font (Pango.FontDescription.from_string ( font ) );
	}

	private static void setWordSelection(Vte.Terminal terminal) {
		terminal.set_word_char_exceptions ( "-/@_&.:?=" );
	}

	public static int main(string[] args) {
		/* Initialise GTK, and the window */
		Gtk.init (ref args);
		var terminal = new Vte.Terminal ();
		var win = new Gtk.Window ();
		win.set_title ("vater");
		
		/* Start a new shell */
		var command = GLib.Environment.get_variable ("SHELL");
		try {
			terminal.spawn_sync (
				Vte.PtyFlags.DEFAULT,
				null,    /* working directory */
				new string[] { command }, /* command */
				null,    /* additional environment */
				0,       /* spawn flags */
				null,    /* child setup */
				null     /* child pid */
				);
		} catch (GLib.Error e) {
			stderr.printf ("Error: %s\n", e.message);
			return 1;
		}
		
		/* individualization */
		setFont (terminal);
		setWordSelection (terminal);

		/* Connect some signals */
		win.destroy.connect (Gtk.main_quit);
		terminal.child_exited.connect (Gtk.main_quit);
		
		/* Put widgets together and run the main loop */
		win.add (terminal);
		win.show_all ();
		Gtk.main ();
		
		return 0;
	}
}
