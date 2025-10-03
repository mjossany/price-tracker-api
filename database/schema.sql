-- Price Tracker Database Schema
-- PostgresSQL 17
-- Created: October 4, 2025

-- =============================
-- TABLES
-- =============================

-- Users table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email_verified BOOLEAN DEFAULT false,
    is_active BOOLEAN DEFAULT true,
    last_login_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Products table
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name TEXT NULL,
    description TEXT,
    image_url TEXT,
    target_price DECIMAL(12,2),
    currency VARCHAR(3) DEFAULT 'BRL',
    notification_enabled BOOLEAN DEFAULT true,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Product Links table (tracks different e-commerce URLs for same product)
CREATE TABLE product_links (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    url TEXT NOT NULL UNIQUE,
    store VARCHAR(100) NOT NULL,
    product_identifier VARCHAR(255),
    last_price DECIMAL(12,2),
    lowest_price_seen DECIMAL(12,2),
    highest_price_seen DECIMAL(12,2),
    last_checked_at TIMESTAMP,
    scrape_error_count INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Price history (time-series data)
CREATE TABLE price_history (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_link_id UUID NOT NULL REFERENCES product_links(id) ON DELETE CASCADE,
    price DECIMAL(12,2) NOT NULL,
    original_price DECIMAL(12,2),
    discount_percentage DECIMAL(5,2),
    currency VARCHAR(3) DEFAULT 'BRL',
    was_available BOOLEAN DEFAULT true,
    scrape_source VARCHAR(50),
    response_time_ms INTEGER,
    checked_at TIMESTAMP DEFAULT NOW()
);

-- =============================
-- INDEXES FOR PERFORMANCE
-- =============================

CREATE INDEX idx_products_user_id ON products(user_id);
CREATE INDEX idx_products_active ON products(is_active) WHERE is_active = true;
CREATE INDEX idx_product_links_product_id ON product_links(product_id);
CREATE INDEX idx_product_links_active ON product_links(is_active) WHERE is_active = true;
CREATE INDEX idx_price_history_link_time ON price_history(product_link_id, checked_at DESC);
