#!/usr/bin/perl -T
# Yes, we want to make sure things work in taint mode

#
# Copyright (C) 2018 Joelle Maslak
# All Rights Reserved - See License
#

#
# Object Construction Tests
#

use strict;
use warnings;
use autodie;

use v5.10;

use Carp;

use Test2::V0;

use File::ByLine;

subtest no_params => sub {
    my $byline = File::ByLine->new();
    ok( defined($byline), "Object created" );

    is( $byline->file(),           undef, "File defaults to empty" );
    is( $byline->header_handler(), undef, "No header handler by default" );
    is( $byline->processes,        1,     "Processes defaults to 1" );
    ok( !$byline->header_skip(), "Header does not skip by default" );
};

subtest with_params_hash => sub {
    my $byline = File::ByLine->new( { file => 'foo.txt', header_skip => 1, processes => 2 } );
    ok( defined($byline), "Object created" );

    is( $byline->file(),           'foo.txt', "File set" );
    is( $byline->header_handler(), undef,     "No header handler by default" );
    is( $byline->processes,        2,         "Processes set to 2" );
    ok( $byline->header_skip(), "Header skip set" );
};

subtest with_params_list => sub {
    my $byline = File::ByLine->new( file => 'foo.txt', header_skip => 1, processes => 2 );
    ok( defined($byline), "Object created" );

    is( $byline->file(),           'foo.txt', "File set" );
    is( $byline->header_handler(), undef,     "No header handler by default" );
    is( $byline->processes,        2,         "Processes set to 2" );
    ok( $byline->header_skip(), "Header skip set" );
};

subtest invalid_param => sub {
    ok dies { File::ByLine->new( foo => 'bar' ) }, "Dies with invalid parameter, list form";
    ok dies { File::ByLine->new( { foo => 'bar' } ) }, "Dies with invalid parameter, hash form";
    ok dies { File::ByLine->new( processes => 1, 'foo' ) },
      "Dies with invalid number of parameters";
};

done_testing();
