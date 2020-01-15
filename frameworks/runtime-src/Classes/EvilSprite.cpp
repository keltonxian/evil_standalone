//
//  EvilSprite.cpp
//  EvilCard
//
//  Created by keltonxian on 7/29/14.
//
//

#include "EvilSprite.h"

#define SHAKE_INTERVAL   0.03
/** @def CCRANDOM_MINUS1_1
 returns a random float between -1 and 1
 */
#define CCRANDOM_MINUS1_1() ((2.0f*((float)rand()/RAND_MAX))-1.0f)

EvilSprite* EvilSprite::create(const std::string& filename)
{
    EvilSprite *sprite = new (std::nothrow) EvilSprite();
    if (sprite && sprite->initWithFile(filename))
    {
        sprite->autorelease();
        return sprite;
    }
    CC_SAFE_DELETE(sprite);
    return nullptr;
}

EvilSprite::EvilSprite(void):shake_times(0),originX(0),originY(0),shake_radius(0)
{
    
}

EvilSprite::~EvilSprite(void)
{
    
}

void EvilSprite::draw(Renderer *renderer, const Mat4 &transform, uint32_t flags)
{
    Sprite::draw(renderer, transform, flags);
}

void EvilSprite::updateShake(float delta)
{
    this->shake_times--;
    if (this->shake_times <= 0) {
        this->setPosition(Vec2(originX, originY));
        this->unschedule(CC_SCHEDULE_SELECTOR(EvilSprite::updateShake));
        return;
    }
    this->setPosition(Vec2(originX + shake_radius * CCRANDOM_MINUS1_1(), originY + shake_radius * CCRANDOM_MINUS1_1()));
}

void EvilSprite::shake(float duration, float radius, float delay)
{
    if (this->shake_times > 0) {
        this->unschedule(CC_SCHEDULE_SELECTOR(EvilSprite::updateShake));
        this->setPosition(Vec2(originX, originY));
    }
    this->originX = this->getPositionX();
    this->originY = this->getPositionY();
    this->shake_radius = radius;
    float interval = SHAKE_INTERVAL;
    this->shake_times = ceil(duration / interval);
//    CCLOG("shake duration[%f],times[%d]", duration, shake_times);
    this->schedule(CC_SCHEDULE_SELECTOR(EvilSprite::updateShake), interval, this->shake_times, delay);
}




