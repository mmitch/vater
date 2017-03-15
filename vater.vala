class Vater : GLib.Object {
	public static int main(string[] args) {
		/* Initialise GTK, and the window */
		Gtk.init (ref args);
		var terminal = new Vte.Terminal ();
		var win = new Gtk.Window ();
		win.set_title ("vater");
		
		/* Start a new shell */
		var command = GLib.Environment.get_variable ("SHELL");
		terminal.spawn_sync (
			Vte.PtyFlags.DEFAULT,
			null,    /* working directory */
			new string[] { command }, /* command */
			null,    /* additional environment */
			0,       /* spawn flags */
			null,    /* child setup */
			null     /* child pid */
			);
		
		/* individualization */
		terminal.set_font( Pango.FontDescription.from_string( "Inconsolata 11" ) );

		/* Connect some signals */
		win.destroy.connect (Gtk.main_quit);
		terminal.child_exited.connect( Gtk.main_quit);
		
		/* Put widgets together and run the main loop */
		win.add (terminal);
		win.show_all ();
		Gtk.main ();
		
		return 0;
	}
}
