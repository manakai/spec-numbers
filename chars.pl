use strict;
use warnings;
use utf8;
use charnames;

my $DigitValue = {};
my $Categories = {};

for (qw(0 ０ 〇 零)) {
  $DigitValue->{$_} = 0;
  push @{$Categories->{$_}}, 'CJK digit';
  push @{$Categories->{$_}}, 'CJK zero';
}
for (qw(1 １ 一 弌 壹 壱)) {
  $DigitValue->{$_} = 1;
  push @{$Categories->{$_}}, 'CJK digit';
  push @{$Categories->{$_}}, 'CJK non-zero digit';
}
for (qw(2 ２ 二 弍 貳 貮 弐 贰)) {
  $DigitValue->{$_} = 2;
  push @{$Categories->{$_}}, 'CJK digit';
  push @{$Categories->{$_}}, 'CJK non-zero digit';
}
for (qw(3 ３ 三 弎 參 参 叁 叄)) {
  $DigitValue->{$_} = 3;
  push @{$Categories->{$_}}, 'CJK digit';
  push @{$Categories->{$_}}, 'CJK non-zero digit';
}
for (qw(4 ４ 四 亖 肆)) {
  $DigitValue->{$_} = 4;
  push @{$Categories->{$_}}, 'CJK digit';
  push @{$Categories->{$_}}, 'CJK non-zero digit';
}
for (qw(5 ５ 五 伍)) {
  $DigitValue->{$_} = 5;
  push @{$Categories->{$_}}, 'CJK digit';
  push @{$Categories->{$_}}, 'CJK non-zero digit';
}
for (qw(6 ６ 六 陸 陆)) {
  $DigitValue->{$_} = 6;
  push @{$Categories->{$_}}, 'CJK digit';
  push @{$Categories->{$_}}, 'CJK non-zero digit';
}
for (qw(7 ７ 七 柒 漆 質)) {
  $DigitValue->{$_} = 7;
  push @{$Categories->{$_}}, 'CJK digit';
  push @{$Categories->{$_}}, 'CJK non-zero digit';
}
for (qw(8 ８ 八 捌)) {
  $DigitValue->{$_} = 8;
  push @{$Categories->{$_}}, 'CJK digit';
  push @{$Categories->{$_}}, 'CJK non-zero digit';
}
for (qw(9 ９ 九 玖)) {
  $DigitValue->{$_} = 9;
  push @{$Categories->{$_}}, 'CJK digit';
  push @{$Categories->{$_}}, 'CJK non-zero digit';
}
for (qw(廿 卄 廾)) {
  $DigitValue->{$_} = 20;
  push @{$Categories->{$_}}, 'CJK multiple tens';
}
for (qw(卅 丗)) {
  $DigitValue->{$_} = 30;
  push @{$Categories->{$_}}, 'CJK multiple tens';
}
for (qw(卌 𠦜)) {
  $DigitValue->{$_} = 40;
  push @{$Categories->{$_}}, 'CJK multiple tens';
}
for (qw(十 拾)) {
  $DigitValue->{$_} = 10;
  push @{$Categories->{$_}}, 'CJK ten';
}
for (qw(百 陌 佰)) {
  $DigitValue->{$_} = 100;
  push @{$Categories->{$_}}, 'CJK hundred';
}
for (qw(皕)) {
  $DigitValue->{$_} = 200;
  push @{$Categories->{$_}}, 'CJK multiple hundreds';
}
for (qw(千 阡 仟)) {
  $DigitValue->{$_} = 1000;
  push @{$Categories->{$_}}, 'CJK thousand';
}
for (qw(万 萬)) {
  $DigitValue->{$_} = 10000;
  push @{$Categories->{$_}}, 'CJK ten thousand';
}
for (qw(億 亿)) {
  $DigitValue->{$_} = 1_0000_0000;
  push @{$Categories->{$_}}, 'CJK hundred million';
}
for (qw(兆)) {
  $DigitValue->{$_} = 1_0000_0000_0000;
  push @{$Categories->{$_}}, 'CJK trillion';
}
for (qw(京)) {
  $DigitValue->{$_} = 1_0000_0000_0000_0000;
  push @{$Categories->{$_}}, 'CJK ten quadrillion';
}
for (qw(有)) {
  push @{$Categories->{$_}}, 'CJK and separator';
  $DigitValue->{$_} = 0+"inf";
}
for (qw(. ． ・)) {
  push @{$Categories->{$_}}, 'CJK decimal separator';
  $DigitValue->{$_} = 0+"inf";
}
for (qw(, ，), "\x20", "\xA0", "\xB7", "\x{2009}", "\x{202F}") {
  push @{$Categories->{$_}}, 'CJK digit group separator';
  $DigitValue->{$_} = 0+"inf";
}

sub p ($$$) {
  printf q{
    <tr itemscope itemtype=cjk-numeral>
      <th><code itemprop=codepoint>U+%04X</code>
      <td><code class=charname>%s</code>
      <td class=char><data>%s</data>
      <td class=value>%s
      <td>%s
  },
      ord $_[0],
      charnames::viacode (ord $_[0]),
      $_[0],
      ($_[1] eq 'Inf' ? '-' : sprintf q{<data itemprop=value>%d</data>}, $_[1]),
      join ', ', map {
        sprintf q{<span itemprop=category>%s</span>}, $_
      } @{$_[2]};
} # p

binmode STDOUT, qw(:encoding(utf-8));
for (sort { $a cmp $b } keys %$DigitValue) {
  p $_, $DigitValue->{$_}, $Categories->{$_};
}

=head1 LICENSE

Per CC0 <https://creativecommons.org/publicdomain/zero/1.0/>, to the
extent possible under law, the author has waived all copyright and
related or neighboring rights to this work.

=cut
