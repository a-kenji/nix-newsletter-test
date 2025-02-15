import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';

export async function GET(context) {
  const blog = await getCollection('blog');
  return rss({
    title: 'Nix Newsletter',
    description: 'A weekly newsletter for nix',
    stylesheet: false,
    site: context.site,
    items: blog.map((post) => ({
      title: post.data.title,
      pubDate: post.data.pubDate,
      description: post.data.description,
      link: `/news/${post.id}/`,
    })),
    customData: '<language>en-us</language>',
    canonicalUrl: 'https://nixos.org',
  });
}
