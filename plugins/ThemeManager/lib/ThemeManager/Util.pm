package ThemeManager::Util;

use strict;

sub theme_label {
    # Grab the theme label. If no template set label is supplied then use
    # the parent plugin's name plus the template set ID.
    my ($set, $obj) = @_;
    return $obj->{registry}->{'template_sets'}->{$set}->{label}
        ? $obj->{registry}->{'template_sets'}->{$set}->{label}
        : eval {$obj->name.': '} . $set;
}

sub theme_thumbnail_url {
    # Build the theme thumbnail URL. If no thumb is supplied, grab the
    # "default" thumbnail.
    my ($set, $obj) = @_;
    my $app = MT->instance;
    return $obj->{registry}->{'template_sets'}->{$set}->{thumbnail}
        ? $app->config('StaticWebPath').'support/plugins/'
            .$obj->key.'/'.$obj->{registry}->{'template_sets'}->{$set}->{thumbnail}
        : $app->config('StaticWebPath').'support/plugins/'
            .'ThemeManager/images/default_theme_thumb-small.png';
}

sub theme_preview_url {
    # Build the theme thumbnail URL. If no thumb is supplied, grab the
    # "default" thumbnail.
    my ($set, $obj) = @_;
    my $app = MT->instance;
    return $obj->{registry}->{'template_sets'}->{$set}->{preview}
        ? $app->config('StaticWebPath').'support/plugins/'
            .$obj->key.'/'.$obj->{registry}->{'template_sets'}->{$set}->{preview}
        : $app->config('StaticWebPath').'support/plugins/'
            .'ThemeManager/images/default_theme_thumb-large.png';
}

sub theme_description {
    # Grab the description. If no template set description is supplied
    # then use the parent plugin's description. This may be a file reference
    # or just some HTML, or even code.
    my ($set, $obj) = @_;
    my $desc = $obj->{registry}->{'template_sets'}->{$set}->{description}
        ? $obj->{registry}->{'template_sets'}->{$set}->{description}
        : eval {$obj->description};
    if (ref $desc eq 'HASH') {
        $desc = MT->handler_to_coderef($desc->{code});
    }
    return $desc->($obj, @_) if ref $desc eq 'CODE';
    if ($desc =~ /\s/) {
        return $desc;
    } else { # no spaces in $about_designer; must be a filename...
        return $obj->load_tmpl($desc);
    }
}

sub theme_author_name {
    # Grab the author name. If no template set author name, then use
    # the parent plugin's author name.
    my ($set, $obj) = @_;
    return $obj->{registry}->{'template_sets'}->{$set}->{author_name}
        ? $obj->{registry}->{'template_sets'}->{$set}->{author_name}
        : eval {$obj->author_name};
}

sub theme_author_link {
    # Grab the author name. If no template set author link, then use
    # the parent plugin's author link.
    my ($set, $obj) = @_;
    return $obj->{registry}->{'template_sets'}->{$set}->{author_link}
        ? $obj->{registry}->{'template_sets'}->{$set}->{author_link}
        : eval {$obj->author_link};
}

sub theme_paypal_email {
    # Grab the paypal donation email address. If no template set paypal
    # email address, then it might have been set at the plugin level.
    my ($set, $obj) = @_;
    return $obj->{registry}->{'template_sets'}->{$set}->{paypal_email}
        ? $obj->{registry}->{'template_sets'}->{$set}->{paypal_email}
        : eval {$obj->paypal_email};
}

sub theme_version {
    # Grab the version number. If no template set version, then use
    # the parent plugin's version.
    my ($set, $obj) = @_;
    return $obj->{registry}->{'template_sets'}->{$set}->{version}
        ? $obj->{registry}->{'template_sets'}->{$set}->{version}
        : eval {$obj->version};
}

sub theme_link {
    # Grab the theme link URL. If no template set theme link, then use
    # the parent plugin's plugin_link.
    my ($set, $obj) = @_;
    return $obj->{registry}->{'template_sets'}->{$set}->{theme_link}
        ? $obj->{registry}->{'template_sets'}->{$set}->{theme_link}
        : eval {$obj->plugin_link};
}

sub theme_docs {
    # Grab the theme doc URL. If no template set theme doc, then use
    # the parent plugin's doc_link.
    my ($set, $obj) = @_;
    return $obj->{registry}->{'template_sets'}->{$set}->{doc_link}
        ? $obj->{registry}->{'template_sets'}->{$set}->{doc_link}
        : eval {$obj->doc_link};
}

sub about_designer {
    # Return the content about the designer. This may be a file reference or 
    # just some HTML, or even code.
    my ($set, $obj) = @_;
    my $about_designer = $obj->{registry}->{'template_sets'}->{$set}->{about_designer};
    if (ref $about_designer eq 'HASH') {
        $about_designer = MT->handler_to_coderef($about_designer->{code});
    }
    return $about_designer->($obj, @_) if ref $about_designer eq 'CODE';
    if ($about_designer =~ /\s/) {
        return "<h3>About the Designer</h3>".$about_designer;
    } else { # no spaces in $about_designer; must be a filename...
        return $obj->load_tmpl($about_designer);
    }
}

1;

__END__